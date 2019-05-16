import QtQuick 2.11
import QtQuick.Controls 2.4
import QtTest 1.2

import "qrc:/"

BaseTestController {
    id: root
    property StackView rootStackView: view.rootStackView

    property Label mainWindowTitle: findChild("MainWindowTitle")
    property ToolButton backButton: findChild("BackButton")

    property Component firstViewControllerComponent: FirstViewTestController {
        testCase: root.testCase
    }

    property Component loginViewControllerComponent: LoginViewTestController {
        testCase: root.testCase
    }

    function waitView(name, component) {
        var view = testCase.waitForOpened(rootStackView, name, 2000)
        var obj = component.createObject()
        obj.view = view
        return obj
    }

    function waitFirstView() {
        return waitView("FirstView", firstViewControllerComponent)
    }


    function waitLoginView() {
        return waitView("LoginView", loginViewControllerComponent)
    }

    function clickOnBackButton() {
        mouseClick(backButton)
    }
}
