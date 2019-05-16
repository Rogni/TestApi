import QtQuick 2.0
import QtQuick.Controls 2.4

BaseTestController {

    property TextField usernameField: findChild("UsernameTextField")
    property TextField passwordField: findChild("PasswordTextField")
    property Button loginButton: findChild("LoginButton")

    function baseChecks() {
        compare(view.title, qsTr("Login"), "Check page title")
        compare(usernameField.placeholderText, qsTr("Username"), "Check username field placeholder text")
        compare(passwordField.placeholderText, qsTr("Password"), "Check password field placeholder text")
        compare(loginButton.text, qsTr("Login"), "Check login button text")
    }


}
