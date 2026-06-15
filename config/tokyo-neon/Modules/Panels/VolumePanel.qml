import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.Core
import qs.Services
import "./Views" as Views

PanelWindow {
    id: root

    required property var volume
    property bool isOpen: false
    required property var config
    required property var globalState
    required property Theme theme

    readonly property int btnSize: root.config.fontSize * 3
    readonly property int btnRadius: root.config.fontSize * 1.5

    visible: isOpen

    color: "#55000000"

    implicitHeight: Screen.height - config.barSize
    implicitWidth: Screen.width
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "volume-panel"
    WlrLayershell.exclusiveZone: -1

    margins.top: config.barSize
    anchors {
        top: true
        right: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.globalState.closeAll();
        }
        onWheel: (wheel) => { 
            var step = 0.05;
            var next = (wheel.angleDelta.y > 0) ? volume.volume + step : volume.volume - step;
            next = Math.max(0, Math.min(1, next));
            volume.setVolume(next);
        }
    }

    FocusScope {
        id: eventHandler

        anchors.fill: parent
        focus: true
        Keys.onEscapePressed: root.globalState.toggleVolumePanel()
        Keys.onUpPressed: volume.increaseVolume()
        Keys.onDownPressed: volume.decreaseVolume()
        Keys.onPressed: (event) => {
            const key = event.text.toUpperCase();
            if (key === "M") {
                volume.toggleMute();
                event.accepted = true;
                return ;
            }

        }
    }

    Rectangle {
        id: panel
        x: parent.width - implicitWidth

        implicitHeight: btnSize * 7 + 64
        implicitWidth: btnSize + 40
        bottomLeftRadius: root.btnRadius
        color: root.theme.bgColor

        Column {
            id: mainColumn

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            Views.Slider {
                icon: volume.icon
                value: volume.volume
                theme: root.theme
                barRadius: btnRadius
                barWidth: btnSize
                fontSize: root.config.fontSize
                fontFamily: root.config.fontFamily
                onChangeRequested: (v) => {
                    return volume.setVolume(v);
                }
            }
            
            Item {
                id: mute

                implicitHeight: root.btnSize
                implicitWidth: root.btnSize

                Rectangle {
                    anchors.fill: parent
                    color: root.volume.muted ? root.theme.mainColor : hoverMute.hovered ? theme.mainAltColor : theme.fgColor
                    radius: root.btnRadius

                    Behavior on color {
                        ColorAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: " "
                        color: root.volume.muted ? root.theme.fgColor : root.theme.bgColor
                        font.pixelSize: root.config.fontSize
                        font.family: root.config.fontFamily
                        font.bold: true

                        Behavior on color {
                            ColorAnimation {
                                duration: 300
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverMute
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.volume.toggleMute()
                }
            }

            Item {
                id: sinkBtn

                implicitHeight: btnSize
                implicitWidth: btnSize
                
                Rectangle {
                    anchors.fill: parent
                    radius: btnRadius
                    color: hoverSinks.hovered ? theme.mainAltColor : globalState.sinkPanelOpen ? theme.mainColor : theme.fgColor

                    Text {
                        anchors.centerIn: parent
                        text: "󱡫"
                        color: globalState.sinkPanelOpen ? theme.fgColor : theme.bgColor
                        font.pixelSize: root.config.fontSize * 1.2
                        font.family: root.config.fontFamily

                        Behavior on color {
                            ColorAnimation {
                                duration: 300
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverSinks
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.globalState.toggleSinkPanel()
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }

        }
    }
}