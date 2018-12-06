from flask import request
from .view_models import error_view_model
from traceback import print_exc

def has_a_parameters(*param_list):
    def decorator(fun):
        def decored():
            if not request.json:
                return error_view_model("JSON body not found")
            for param in param_list:
                if not param in request.json:
                    return error_view_model("Parameter {} not found".format(param))
            return fun()
        return decored
    return decorator

def handle_500(fun):
    def decorator():
        try:
            return fun()
        except Exception as ex:
            print_exc()
            print(ex)

            return error_view_model("Server error")
    return decorator

def base_handle(has_parameters):
    def decorator(fun):
        @handle_500
        @has_a_parameters(*has_parameters)
        def decored():
            return fun()
        return decored
    return decorator

def check(result, err_str):
    def decorator(fun):
        def decored():
            if not result:
                return error_view_model(err_str)
            return fun()
        return decored
    return decorator