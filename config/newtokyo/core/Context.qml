import QtQuick
import qs.core
import qs.services

Item {
    id: root

    property var config: Config
    property alias theme: themeService
    property alias overlayState: overlayState
    property alias time: timeService
    property var audio: AudioService 

    Theme {
        id: themeService
    }

    OverlayState {
        id: overlayState
    }

    TimeService {
        id: timeService
    }
}