import QtQuick 2.11
import QtQuick.Controls 2.4

BaseView {
    title: qsTr("Client")

    Column {
        anchors.centerIn: parent
        spacing: 8
        Button {
            text: qsTr("Login")
            onClicked: {
                push(loginViewComponent.createObject())
            }
        }
        Button {
            text: qsTr("Register")
            onClicked: {
                push(registerViewComponent.createObject())
            }
        }
    }

    Component {
        id: loginViewComponent
        LoginView {
        }
    }
    Component {
        id: registerViewComponent
        RegisterView {
        }
    }
}
