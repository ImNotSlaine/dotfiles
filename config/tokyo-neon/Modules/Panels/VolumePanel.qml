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

    color: "transparent"

    //implicitHeight: btnSize * 6 + 52
    //implicitWidth: btnSize + 40
    implicitHeight: Screen.height - config.barSize
    implicitWidth: Screen.width
    WlrLayershell.layer: WlrLayer.Overlay
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
            root.globalState.toggleVolumePanel();
        }
    }

    FocusScope {
        id: eventHandler

        anchors.fill: parent
    }

    Rectangle {
        id: panel
        x: parent.width - implicitWidth

        implicitHeight: btnSize * 6 + 52
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
                    color: root.volume.muted ? root.theme.mainColor : root.theme.fgColor
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
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.volume.toggleMute()
                }
            }

        }
    }
}