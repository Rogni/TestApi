import QtQuick 2.11
import QtQuick.Controls 2.4

BaseView {
    title: qsTr("Register")

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
        TextField {
            id: emailTextField
            placeholderText: qsTr("Email")
            selectByMouse: true
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Register")
            onClicked: {
                apiManager.userApi.register(
                            usernameTextField.text,
                            passwordTextField.text,
                            emailTextField.text,
                            function (status, response) {
                                if (status===200 && !response.error) {
                                    registerSuccess()
                                } else {
                                    registerFailed(response.error)
                                }
                            })
            }
        }
    }

    function registerSuccess() {
        pop()
        push(mainViewComponent.createObject())
    }

    function registerFailed(error) {
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

    Component {
        id: mainViewComponent
        MainView {

        }
    }
}
