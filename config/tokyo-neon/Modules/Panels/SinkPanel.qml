import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.Core
import qs.Services

PanelWindow {
    id: root

    required property var sinks
    required property var defaultSink
    required property var volume
    property bool isOpen: false
    required property var config
    required property var globalState
    required property Theme theme

    readonly property int btnSize: root.config.fontSize * 3
    readonly property int btnRadius: root.config.fontSize * 1.5

    visible: isOpen

    color: "#55000000"

    implicitHeight: Screen.desktopAvailableHeight - config.barSize
    implicitWidth: Screen.width
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "sink-panel"
    WlrLayershell.exclusiveZone: -1

    anchors {
        right: true
        bottom: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.globalState.toggleSinkPanel();
        }
    }

    FocusScope {
        id: eventHandler

        anchors.fill: parent
        focus: true
        Keys.onEscapePressed: root.globalState.toggleSinkPanel();
    }

    Rectangle {
        id: panel
        x: parent.width - implicitWidth
        y: parent.height / 2 - implicitHeight / 2

        implicitHeight: btnSize + 40
        implicitWidth: btnSize * ( sinks.length + 1 ) + 48

        topLeftRadius: btnRadius
        bottomLeftRadius: btnRadius

        color: theme.bgColor

        Row {
            id: mainRow

            anchors.centerIn: parent
            spacing: 12

            Repeater {
                model: sinks

                Rectangle {
                    required property var modelData
                    required property int index

                    height: btnSize
                    width: btnSize
                    radius: btnRadius

                    color: if (defaultSink.id == sinks[index].id) {
                            return theme.mainColor ; 
                        } else if (hoverBtn.hovered) {
                            return theme.mainAltColor ; 
                        } else {
                            return theme.fgColor ;
                        }
                    visible: true

                    Behavior on color {
                        ColorAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }
                    }

                    Text {
                        text: if (root.sinks[index].name.match("hdmi")) {
                                return "" ;
                        } else {
                            return ""
                        }
                        color: if (defaultSink.id == sinks[index].id) {
                            return theme.fgColor ; 
                        } else {
                            return theme.bgColor ;
                        }

                        anchors.centerIn: parent
                        font.pixelSize: root.config.fontSize
                        font.family: root.config.fontFamily

                        Behavior on color {
                            ColorAnimation {
                                duration: 300
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: volume.setDefaultSink(sinks[index])
                    }

                    HoverHandler {
                        id: hoverBtn
                    }
                }

            }
        }

    }
}
