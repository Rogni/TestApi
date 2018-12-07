from sqlalchemy import Column, String, Integer
from passlib.apps import custom_app_context as pwd_context
from app import db, app
from itsdangerous import (TimedJSONWebSignatureSerializer
                          as Serializer, BadSignature, SignatureExpired)

class User(db.Model):

    id = Column(Integer, primary_key=True)
    username = Column(String(80), unique=True, nullable=False)
    email = Column(String(120), unique=True, nullable=False)
    password_hash = Column(String(120), unique=False, nullable=False)

    def hash_password(self, password):
        self.password_hash = pwd_context.encrypt(password)

    def verify_password(self, password):
        return pwd_context.verify(password, self.password_hash)

    def __repr__(self):
        return "<User{0}>".format((self.id, self.username, self.email, self.password_hash))

    def generate_auth_token(self, expiration = 600):
        s = Serializer(app.config['SECRET_KEY'], expires_in = expiration)
        return s.dumps({ 'id': self.id })
    
    @staticmethod
    def user_by_name(username):
        return User.query.filter_by(username=username).first()
    
    @staticmethod
    def user_by_email(email):
        return User.query.filter_by(email=email).first()

    @staticmethod
    def register_user(username, password, email):
        user = User(username=username, email=email)
        user.hash_password(password)
        db.session.add(user)
        db.session.commit()
        return user
    
    @staticmethod
    def login_user(username, password):
        user = User.user_by_name(username)
        if user.verify_password(password):
            return user
        else:
            return None

    @staticmethod
    def verify_auth_token(token):
        s = Serializer(app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except SignatureExpired:
            return None # valid token, but expired
        except BadSignature:
            return None # invalid token
        user = User.query.get(data['id'])
        return user

    