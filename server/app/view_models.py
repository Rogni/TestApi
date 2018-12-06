from flask import jsonify

def error_view_model(error):
    return jsonify({
        "error": str(error)
    })