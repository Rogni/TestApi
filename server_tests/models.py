import random, string

def random_string(str_len, chars = string.ascii_lowercase + string.ascii_uppercase + string.digits):
    return "".join((random.choice(chars) for _ in range(str_len)))

class UserModel:
    username = None
    password = None
    email = None
    token = None
    id = None
    def __init__(self, **kwargs):
        self.username = kwargs.get("username", random_string(7))
        self.password = kwargs.get("password", random_string(7))
        self.email = kwargs.get("email", "{}@{}.{}".format(
            random_string(7),
            random_string(4),
            random_string(2)
        ))
    
    def __eq__(self, other):
        try:
            return self.username == other.username and \
                    self.email == other.email
        except Exception as ex: 
            print(ex)
            return False
    
    def __repr__(self):
        return "<{}{}>".format("UserModel", (self.username, self.password, self.email))

    