<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>User Profiles</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: sans-serif;
      background: #f0f2f5;
      min-height: 100vh;
      padding: 40px 16px;
    }

    .container {
      max-width: 650px;
      margin: 0 auto;
    }

    h1 {
      text-align: center;
      margin-bottom: 30px;
      color: #222;
    }

    .card {
      background: white;
      border-radius: 10px;
      padding: 24px;
      margin-bottom: 24px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    .card h2 {
      margin-bottom: 16px;
      font-size: 18px;
      color: #333;
    }

    input {
      width: 100%;
      padding: 10px 12px;
      margin-bottom: 12px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 14px;
    }

    input:focus {
      outline: none;
      border-color: #4f46e5;
    }

    button.add-btn {
      width: 100%;
      padding: 10px;
      background: #4f46e5;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 15px;
      cursor: pointer;
    }

    button.add-btn:hover { background: #4338ca; }

    .error { color: red; font-size: 13px; margin-top: 8px; }

    .user-card {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: white;
      border-radius: 10px;
      padding: 16px 20px;
      margin-bottom: 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }

    .avatar {
      width: 46px;
      height: 46px;
      border-radius: 50%;
      background: #4f46e5;
      color: white;
      font-size: 18px;
      font-weight: bold;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 16px;
      flex-shrink: 0;
    }

    .info { flex: 1; }
    .info .name { font-weight: 600; font-size: 15px; color: #111; }
    .info .meta { font-size: 13px; color: #666; margin-top: 2px; }

    button.del-btn {
      background: #fee2e2;
      color: #dc2626;
      border: none;
      padding: 6px 14px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
    }

    button.del-btn:hover { background: #fecaca; }

    .empty {
      text-align: center;
      color: #aaa;
      padding: 20px 0;
      font-size: 14px;
    }
  </style>
</head>
<body>

  <div class="container">
    <h1>User Profiles</h1>

    <div class="card">
      <h2>Add User</h2>
      <input id="name"  type="text"  placeholder="Full Name" />
      <input id="email" type="email" placeholder="Email Address" />
      <input id="age"   type="number" placeholder="Age" min="1" />
      <button class="add-btn" onclick="addUser()">Add User</button>
      <p class="error" id="err"></p>
    </div>

    <div class="card">
      <h2>All Users</h2>
      <div id="user-list"><p class="empty">No users yet.</p></div>
    </div>
  </div>

  <script>
    async function fetchUsers() {
      const res = await fetch("/api/users");
      const users = await res.json();
      const list = document.getElementById("user-list");

      if (users.length === 0) {
        list.innerHTML = '<p class="empty">No users yet.</p>';
        return;
      }

      list.innerHTML = users.map(u => `
        <div class="user-card">
          <div class="avatar">${u.name[0].toUpperCase()}</div>
          <div class="info">
            <div class="name">${u.name}</div>
            <div class="meta">${u.email} &nbsp;|&nbsp; Age: ${u.age}</div>
          </div>
          <button class="del-btn" onclick="deleteUser(${u.id})">Delete</button>
        </div>
      `).join("");
    }

    async function addUser() {
      const name  = document.getElementById("name").value.trim();
      const email = document.getElementById("email").value.trim();
      const age   = document.getElementById("age").value.trim();
      const err   = document.getElementById("err");
      err.textContent = "";

      if (!name || !email || !age) {
        err.textContent = "All fields are required.";
        return;
      }

      const res = await fetch("/api/users", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name, email, age })
      });

      if (!res.ok) {
        const data = await res.json();
        err.textContent = data.error;
        return;
      }

      document.getElementById("name").value = "";
      document.getElementById("email").value = "";
      document.getElementById("age").value = "";
      fetchUsers();
    }

    async function deleteUser(id) {
      await fetch(`/api/users/${id}`, { method: "DELETE" });
      fetchUsers();
    }

    fetchUsers();
  </script>

</body>
</html>