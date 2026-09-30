import QtQuick
import qs.core

Item {
    id: root

    property var config: Config
    property alias theme: themeService

    Theme {
        id: themeService
    }
}