import QtQuick 2.11
import QtQuick.Controls 2.4
import "../core"

Page {
    id: root

    property ApiManager apiManager
    property StackView stackView
    function push(item) {
        item.stackView = stackView
        item.apiManager = apiManager
        stackView.push(item)
    }

    function pop() {
        return stackView ? stackView.pop() : null
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#88f9db";
            }
            GradientStop {
                position: 0.62;
                color: "#0171a8";
            }
            GradientStop {
                position: 1.00;
                color: "#c67d00";
            }
        }
    }


}
