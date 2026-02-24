# from flask import Flask, request 

# app = Flask(__name__)

# # www.ownwebsite.com/even_odd
# # www.google.com/mail
# # www.google.com/drive
# @app.route("/" , methods = ["GET"])
# def welcome():
#     return " Welcome to EVEN or ODD application "

# @app.route("/even_odd", methods=["GET"])
# def even_odd():
#     num = request.args.get("num")
#     num = int(num)
#     if num % 2 == 0 :
#         return f"{num} is Even"
#     else :
#         return f"{num} is Odd"

# if __name__ == "__main__":
#     app.run(host = "0.0.0.0", port = 5000)




def even_odd(n):
    if n % 2 == 0 :
        print("even")
    else :
        print("odd")













































