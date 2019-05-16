import QtQuick 2.11
import QtQuick.Controls 2.4

BaseView {
    objectName: "LoginView"
    title: qsTr("Login")
    Column {
        spacing: 8
        anchors.centerIn: parent
        TextField {
            id: usernameTextField
            placeholderText: qsTr("Username")
            selectByMouse: true
        }
        TextField {
            id: passwordTextField
            placeholderText: qsTr("Password")
            selectByMouse: true
            echoMode: TextField.Password
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Login")
            onClicked: {
                userManager.login(
                            usernameTextField.text,
                            passwordTextField.text,
                            function (response) {
                                if (response.error) {
                                    loginFailed(response.error)
                                }
                            })
            }
        }
    }

    function loginFailed(error) {
        errLabel.text = error
        errorPopup.open()
    }

    Popup {
        id: errorPopup
        visible: false
        leftMargin: 8
        rightMargin: 8
        Label {
            id: errLabel
            width: parent.width
            wrapMode: Text.WordWrap
        }
    }
}
