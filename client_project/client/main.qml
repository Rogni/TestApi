import QtQuick 2.11
import QtQuick.Controls 2.4
import "views"
import "core"

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ApiManager {
        id: apiManager
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
                text: qsTr("Back to %1").arg(
                          rootStackView.index > 0 ?
                              rootStackView.get(rootStackView.index - 1).title :
                              rootStackView.initialItem.title
                          )
                onClicked: rootStackView.pop()
            }

        }
        Label {
            color: "#ffffff"
            anchors.centerIn: parent
            text: rootStackView.currentItem.title
            font.pointSize: 12
        }


    }

    StackView {
        id: rootStackView
        anchors.fill: parent
        initialItem: FirstView {
            stackView: rootStackView
            apiManager: apiManager
        }
    }
}
