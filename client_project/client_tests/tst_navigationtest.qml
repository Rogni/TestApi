import QtQuick 2.0
import QtTest 1.0
import "TestHelpers"
import "TestControllers"
import "qrc:/"

BaseTestCase {
    id: rootTestCase
    name: "NavigationTest"

    Component {
        id: mainWindowComponent
        MainWindowTestController {
            view: MainWindow {

            }
            testCase: rootTestCase
        }
    }

    function initTestCase() {
    }

    function test_FirstViewLoaded() {
        var mainControllerWindow = mainWindowComponent.createObject()
        var firstViewController = mainControllerWindow.waitFirstView()
        compare(firstViewController.view.title, qsTr("Client"), "First view has title: 'Client'")
        mainControllerWindow.checkTitle(qsTr("Client"))
    }

    function test_hasLoginAndRegisterButton() {
        var mainControllerWindow = mainWindowComponent.createObject()
        var firstViewController = mainControllerWindow.waitFirstView()
        firstViewController.checks()

    }

    function test_MoveToLoginView() {
        var mainControllerWindow = mainWindowComponent.createObject()
        var firstViewController = mainControllerWindow.waitFirstView()
        firstViewController.clickOnLogin()
        var loginViewController = mainControllerWindow.waitLoginView()
        loginViewController.baseChecks()
        mainControllerWindow.checkTitle(qsTr("Login"))

        mainControllerWindow.clickOnBackButton()
        firstViewController = mainControllerWindow.waitFirstView()
        mainControllerWindow.checkTitle(qsTr("Client"))
    }

    function test_MoveToRegisterView() {

    }

    function cleanupTestCase() {
    }


}
