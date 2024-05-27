def valid_user():
    return {
        "name": "string",
        "email": "string",
        "password": "string",
        "register_": "string"
    }

def valid_user_update():
    return {
        "name": "stringg",
        "email": "string@email",
        "password": "string",
        "register_": "string"
    }

def valid_login():
    return {
        "email": "string",
        "password": "string"
    }

def valid_user_change_admin():
    return {
        "register_": "string",
        "is_admin": True
    }