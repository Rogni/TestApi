import QtQuick 2.11
import Qt.labs.settings 1.0

QtObject {
    id: user
    property string username: ""
    property string email: ""
    property int user_id: 0
    property string token: ""

    property Settings userSettings: Settings {
        category: "User"
        property alias username: user.username
        property alias email: user.email
        property alias token: user.token
        property alias user_id: user.user_id
    }
}
