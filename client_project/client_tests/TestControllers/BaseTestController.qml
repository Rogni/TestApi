import QtQuick 2.0
import QtTest 1.2

QtObject {
    property TestCase testCase
    property var view

    function mouseClick(item) {
        return testCase.mouseClick(item)
    }

    function findChild(objname) {
        return testCase.findChild(view, objname)
    }
}
