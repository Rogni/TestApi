from .UserModels import User
from .UserViewModels import (
                            user_not_found_view_model, 
                            username_already_exist, 
                            email_already_exist
                            ) 
from app.view_models import error_view_model

def user_found(username=None, email=None):
    def decorator(fun):
        def decored():
            user = None
            if username:
                user = User.user_by_name(username)
            elif email:
                user = User.user_by_email(email)
            if not user:
                return user_not_found_view_model(username)
            return fun()
        return decored
    return decorator

def user_not_found(username=None, email=None):
    def decorator(fun):
        def decored():
            if username:
                user = User.user_by_name(username)
                if user:
                    return username_already_exist(username)
            if email:
                user = User.user_by_email(email)
                if user:
                    return email_already_exist(email)
            return fun()
        return decored
    return decorator


def user_token_valid(token):
    def decorator(fun):
        def decored():
            user = User.verify_auth_token(token)
            if user:
                return fun(user=user)
            else:
                return error_view_model("Invalid token")
        return decored
    return decorator