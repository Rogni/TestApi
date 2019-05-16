import QtQuick 2.11
import QtQuick.Controls 2.4

BaseTestController {

    property Button loginButton: view ? testCase.findChild(view, "LoginButton") : null
    property Button registerButton: view ? testCase.findChild(view, "RegisterButton") : null


    function checks() {
        testCase.compare(view.title, qsTr("Client"))
        testCase.compare(loginButton.text, qsTr("Login"))
        testCase.compare(registerButton.text, qsTr("Register"))
    }

    function clickOnLogin() {
        mouseClick(loginButton)
    }

    function clickOnRegister() {
        mouseClick(registerButton)
    }
}
