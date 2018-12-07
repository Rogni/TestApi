import QtQuick 2.12
import QtQuick.Controls 2.12
import "views"
import "core"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ApiManager {
        id: rootApiManager
    }

    UserManager {
        id: rootUserManager
        apiManager: rootApiManager
        onUserLoginSig: {
            rootStackView.clear()
            rootView.push(mainViewComponent.createObject())
        }
        onUserLogoutSig: {
            rootStackView.clear()
            rootView.push(firstViewComponent.createObject())
        }
    }

    header: ToolBar {
        Rectangle {
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#4d9ac0";
                }
                GradientStop {
                    position: 0.46;
                    color: "#006c9e";
                }
                GradientStop {
                    position: 1.00;
                    color: "#253ca0";
                }
            }
            anchors.fill: parent
        }

        Row {
            spacing: 4
            padding: 4
            ToolButton {
                background: Item {}
                visible: rootStackView.depth > 1
                text: qsTr("<")
                onClicked: rootStackView.pop()
                font.pointSize: 12
                contentItem: Text {
                        text: parent.text
                        font: parent.font
                        opacity: enabled ? 1.0 : 0.3
                        color: parent.down ? "#99999999" : "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
            }

        }
        Label {
            color: "#ffffff"
            anchors.centerIn: parent
            text: rootStackView.currentItem ? rootStackView.currentItem.title : ""
            font.pointSize: 12
        }

        Row {
            spacing: 4
            padding: 4
            visible: rootUserManager.isUserLogget
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Label {
                text: rootUserManager.user.username
                anchors.verticalCenter: parent.verticalCenter
                color: "#ffffff"
                font.pointSize: 12
            }

            ToolButton {
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    opacity: enabled ? 1.0 : 0.3
                    color: parent.down ? "#99999999" : "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                font.pointSize: 12
                text: qsTr("Exit")
                background: Item {}
                onClicked: {
                    rootUserManager.logout()
                }
            }
        }

    }

    StackView {
        id: rootStackView
        anchors.fill: parent
        initialItem: RootView {
            id: rootView
            stackView: rootStackView
            apiManager: rootApiManager
            userManager: rootUserManager
        }
    }

    Component {
        id: mainViewComponent
        MainView {}
    }

    Component {
        id: firstViewComponent
        FirstView {}
    }
}
