from app import app
from app import decorators
from app.view_models import error_view_model
from .UserModels import User
from .UserViewModels import user_login_view_model
from flask import request, jsonify
from .decorators import user_found, user_not_found, user_token_valid
from expynent import EMAIL_ADDRESS
import re

EMAIL_REG = re.compile(EMAIL_ADDRESS)

@app.route('/user/login', methods=['GET','POST'])
def user_login():
    @decorators.base_handle(has_parameters=["username", "password"])
    def __user_login():
        username = request.json.get("username")
        password = request.json.get("password")
        @user_found(username)
        def make_response():
            user = User.login_user(username, password)
            if user:
                return user_login_view_model(user)
            else:
                return error_view_model("Login failed")
        return make_response()
    return __user_login()

@app.route('/user/register', methods=['POST'])
def user_register():
    @decorators.base_handle(has_parameters=["username", "password", "email"])
    def __register():
        username = request.json.get("username")
        email = request.json.get("email").lower()
        password = request.json.get("password")
        @decorators.check(len(username) > 6, "Username must be greater than 6 characters")
        @decorators.check(EMAIL_REG.match(email), "Not valid email")
        @decorators.check(len(password) > 6, "Password must be greater than 6 characters")
        @user_not_found(username, email)
        def make_response():
            print(username, email)
            user = User.register_user(username, password, email)
            if user:
                return user_login_view_model(user)
            else:
                return error_view_model("User not registred")
        return make_response()
    return __register()

@app.route('/user/curr_user', methods=['POST'])
def curr_user():
    @decorators.base_handle(has_parameters=["token"])
    @user_token_valid(request.json.get("token"))
    def __curr_user(user=None):
        return user_login_view_model(user)
    return __curr_user()
