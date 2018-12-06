from config import SERVER
from models import UserModel
from requests import post, get

LOGIN_URL = "{}/user/login".format(SERVER)
REGISTER_URL = "{}/user/register".format(SERVER)
CURR_USER = "{}/user/curr_user".format(SERVER)


class UserApi:
    @staticmethod
    def register_user(usr: UserModel, method=post):
        #make parem dictionary
        params = {
            "username": usr.username,
            "password": usr.password,
            "email": usr.email
        }
        #send register user request to server
        return method(REGISTER_URL, json = params)
        
    @staticmethod
    def login_user(usr: UserModel, method=post):
        params = {
            "username": usr.username,
            "password": usr.password,
        }
        return method(LOGIN_URL, json = params)
    
    @staticmethod
    def current_user(token:str, method=post):
        params = {
            "token": token
        }
        return method(CURR_USER, json=params)