import QtQuick 2.11
import "./api_models"

QtObject {
    id: root

    signal userLoginSig()
    signal userLogoutSig()

    property ApiManager apiManager

    function login(username, password, callback) {
        callback = callback || function (response) {}

        apiManager.userApi.login(username, password, function(response) {
            if (!response.error) {
                onUserLogget(response)
            }
            callback( response)
        })
    }

    function register(username, password, email, callback) {
        callback = callback || function (response) {}
        apiManager.userApi.register(username, password, email, function(response) {
            if (!response.error) {
                onUserLogget(response)
            }
            callback( response)
        })
    }

    function getCurrentUser() {
        apiManager.userApi.currentUser(user.token, function (response) {
            if (!response.error) {
                onUserLogget(response)
            } else {
                logout()
            }
        })
    }

    function logout() {
        user.token = ""
        userLogoutSig()
    }

    function onUserLogget(response) {
        user.mapUserResponse(response)
        userLoginSig()
    }

    Component.onCompleted: getCurrentUser()

    property UserApiModel user: UserApiModel {
        function mapUserResponse(response) {
            token = response.token
            username = response.user.username
            user_id = response.user.id
            email = response.user.email
        }
    }
}
