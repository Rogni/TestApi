import QtQuick 2.0
import QtTest 1.12

TestCase {
    function waitForOpened(parent, nameObject, timeout) {
        timeout = timeout || 1000
        tryVerify(
                    function () { return findChild(parent, nameObject)},
                    timeout,
                    "Wait for opened: %1".arg(nameObject)
                 )
        return findChild(parent, nameObject)
    }
}
