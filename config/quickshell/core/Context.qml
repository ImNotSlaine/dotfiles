import QtQuick
import qs.core
import qs.services

Item {
    id: root

    property var config: Config
    property alias theme: themeService
    property alias time: timeService

    Theme {
        id: themeService
    }

    TimeService {
        id: timeService
    }
}