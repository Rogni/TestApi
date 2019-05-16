import QtQuick 2.0
import QtTest 1.2

QtObject {
    property TestCase testCase
    property var view

    function compare(actual, expected, msg) {
        testCase.compare(actual, expected, msg)
    }

    function mouseClick(item) {
        return testCase.mouseClick(item)
    }

    function findChild(objname) {
        return testCase.findChild(view, objname)
    }
}
