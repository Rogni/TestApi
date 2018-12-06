from flask import jsonify
def user_login_view_model(user):
    return jsonify({
        "user": {
            "id": user.id,
            "username": user.username,
            "email": user.email
        },
        "token": user.generate_auth_token().decode('ascii')
    })


def user_not_found_view_model(user):
    return jsonify({
        "error": "User {} not found".format(user)
    })

def username_already_exist(username):
    return jsonify({
        "error": "Username {} already exist".format(username)
    })

def email_already_exist(email):
    return jsonify({
        "error": "Email {} already exist".format(email)
    })