import QtQuick 2.11
import Qt.labs.settings 1.0

QtObject {
    id: root

    signal userLoginSig()
    signal userLogoutSig()

    function userLogin (token) {
        userToken = token
        userLoginSig()
    }

    function userLogout() {
        userToken = ""
        userLogoutSig()
    }

    property string userToken: userSettings.token

    property Settings userSettings: Settings {
        property string token: root.userToken
    }
}
