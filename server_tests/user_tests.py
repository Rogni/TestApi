import pytest
from models import UserModel, random_string
from api import UserApi

class TestRegisterUserApi:
    first_user = UserModel()
    second_user = UserModel()

    def check_user_register_success(self, usr: UserModel, response_body):
        assert not 'error' in response_body
        assert 'user' in response_body
        assert 'token' in response_body
        user = response_body.get('user')
        assert 'id' in user
        assert 'username' in user
        assert 'email' in user
        username = user.get('username')
        email = user.get('email')
        assert username == usr.username
        assert email == usr.email
    
    def check_user_view_model(self, usr: UserModel, response_body):
        assert not 'error' in response_body
        assert 'user' in response_body
        assert 'token' in response_body
        user = response_body.get('user')
        assert 'id' in user
        assert 'username' in user
        assert 'email' in user
        username = user.get('username')
        email = user.get('email')
        usr_id = user.get('id')
        assert username == usr.username
        assert email == usr.email
        assert usr_id == usr.id
    
    def check_error(self, response, error):
        assert len(response) == 1 # only error
        assert 'error' in response
        assert response.get('error') == error
        

    def test_register_users(self):
        response_body = UserApi.register_user(self.first_user).json()
        self.check_user_register_success(self.first_user, response_body)
        self.first_user.token = response_body.get('token')
        self.first_user.id = response_body.get('user').get('id')

        response_body = UserApi.register_user(self.second_user).json()
        self.check_user_register_success(self.second_user, response_body)
        self.second_user.token = response_body.get('token')
        self.second_user.id = response_body.get('user').get('id')
    
    @pytest.mark.dependency(depends=['test_register_users'])
    def test_users_login(self):
        response_body = UserApi.login_user(self.first_user).json()
        self.check_user_view_model(self.first_user, response_body)
        self.first_user.token = response_body.get('token')

        response_body = UserApi.login_user(self.second_user).json()
        self.check_user_view_model(self.second_user, response_body)
        self.second_user.token = response_body.get('token')
    
    @pytest.mark.dependency(depends=['test_register_users'])
    def test_curr_user(self):
        response = UserApi.current_user(self.first_user.token).json()
        self.check_user_view_model(self.first_user, response)
        self.first_user.token = response.get('token')

        response = UserApi.current_user(self.second_user.token).json()
        self.check_user_view_model(self.second_user, response)
        self.second_user.token = response.get('token')
    
    @pytest.mark.dependency(depends=['test_register_users'])
    def test_login_failed(self):
        usr = UserModel(
            username = self.first_user.username,
            password = random_string(7)
        )
        response_body = UserApi.login_user(usr).json()
        self.check_error(response_body, "Login failed")

    @pytest.mark.dependency(depends=['test_register_users'])
    def test_register_user_failed(self):
        usr = UserModel(
            username=self.first_user.username,
            password=self.first_user.password,
            email=self.first_user.email
        )
        response_body = UserApi.register_user(usr).json()
        self.check_error(response_body, 'Username {} already exist'.format(usr.username))

        usr.username = random_string(7)
        response_body = UserApi.register_user(usr).json()
        self.check_error(response_body, 'Email {} already exist'.format(usr.email))

        usr.email = random_string(7)
        response_body = UserApi.register_user(usr).json()
        self.check_error(response_body, 'Not valid email')

        usr.email = "{}@{}.{}".format(random_string(7), random_string(3), random_string(2))
        usr.username = random_string(6)
        response_body = UserApi.register_user(usr).json()
        self.check_error(response_body, "Username must be greater than 6 characters")

        usr.username = random_string(7)
        usr.password = random_string(6)
        response_body = UserApi.register_user(usr).json()
        self.check_error(response_body, "Password must be greater than 6 characters")


