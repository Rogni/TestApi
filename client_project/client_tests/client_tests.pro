CONFIG += warn_on qmltestcase

TEMPLATE = app

RESOURCES += ../client/qml.qrc

DISTFILES += \
    TestControllers/BaseTestController.qml \
    TestControllers/FirstViewTestController.qml \
    TestControllers/LoginViewTestController.qml \
    TestControllers/MainWindowTestController.qml \
    TestControllers/RegisterViewTestController.qml \
    TestHelpers/BaseTestCase.qml \
    tst_navigationtest.qml

SOURCES += \
    main.cpp


