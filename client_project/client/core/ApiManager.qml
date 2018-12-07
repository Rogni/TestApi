import QtQuick 2.11

QtObject {
    id: root

    property string serverUrl: "http://127.0.0.1:5000"



    property QtObject userApi: QtObject {
        property string userApiUrl: "%1/user".arg(root.serverUrl)

        property string loginUrl: "%1/login".arg(userApiUrl)
        property string registerUrl: "%1/register".arg(userApiUrl)
        property string currentUserUrl: "%1/curr_user".arg(userApiUrl)

        function login(username, password, callback) {
            root.baseJSONRequest(loginUrl, 'POST', {username:username, password: password}, callback)
        }

        function register(username, password, email, callback) {
            root.baseJSONRequest(registerUrl, 'POST', {username:username, password: password, email:email}, callback)
        }

        function currentUser(token, callback) {
            root.baseJSONRequest(currentUserUrl, 'POST', {token:token}, callback)
        }


    }

    function baseJSONRequest(url, method, params, callback) {
        callback = callback || function (status, response) {}
        var request = new XMLHttpRequest()
        request.open(method, url)
        request.setRequestHeader('Content-Type', 'application/json')
        request.onreadystatechange = function () {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    callback(JSON.parse(request.responseText))
                } else {
                    callback({error: "Server error"})
                }
            }
        }
        var data = JSON.stringify(params)
        request.setRequestHeader('Content-Length', data.length)
        request.send(data)
    }
}
