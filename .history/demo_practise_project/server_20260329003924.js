const http = require("http");
const fs = require("fs");
const path = require("path");

let users = [];
let nextId = 1;

const server = http.createServer((req, res) => {

  // Serve index.html
  if (req.method === "GET" && req.url === "/") {
    const filePath = path.join(__dirname, "index.html");
    fs.readFile(filePath, (err, data) => {
      if (err) { res.writeHead(500); res.end("Error"); return; }
      res.writeHead(200, { "Content-Type": "text/html" });
      res.end(data);
    });
    return;
  }

  // GET all users
  if (req.method === "GET" && req.url === "/api/users") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify(users));
    return;
  }

  // POST add user
  if (req.method === "POST" && req.url === "/api/users") {
    let body = "";
    req.on("data", chunk => body += chunk);
    req.on("end", () => {
      const { name, email, age } = JSON.parse(body);

      if (!name || !email || !age) {
        res.writeHead(400, { "Content-Type": "application/json" });
        res.end(JSON.stringify({ error: "All fields are required" }));
        return;
      }

      const user = { id: nextId++, name, email, age };
      users.push(user);
      res.writeHead(201, { "Content-Type": "application/json" });
      res.end(JSON.stringify(user));
    });
    return;
  }

  // DELETE user
  if (req.method === "DELETE" && req.url.startsWith("/api/users/")) {
    const id = parseInt(req.url.split("/")[3]);
    users = users.filter(u => u.id !== id);
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ message: "Deleted" }));
    return;
  }

  // 404
  res.writeHead(404);
  res.end("Not Found");
});

server.listen(3000, () => console.log("Server running at http://localhost:3000"));