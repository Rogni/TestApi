import QtQuick 2.11
import QtQuick.Controls 2.4

BaseView {
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
                apiManager.userApi.login(
                            usernameTextField.text,
                            passwordTextField.text,
                            function (status, response) {
                                if (status===200 && !response.error) {
                                    loginSuccess()
                                } else {
                                    loginFailed(response.error)
                                }
                            })
            }
        }
    }

    function loginSuccess() {
        pop()
        push(mainViewComponent.createObject())
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



    Component {
        id: mainViewComponent
        MainView {

        }
    }
}
