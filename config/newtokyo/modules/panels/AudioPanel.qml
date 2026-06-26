import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.core
import qs.services
import "./elements" as Elements

Variants {
    id: panelVariant

    model: Quickshell.screens

    required property Context context
    PanelWindow {
        id: root

        required property var modelData 
        screen: modelData

        property var context: panelVariant.context

        property var audio: context.audio

        readonly property int btnSize: root.context.config.fontSize * 3
        readonly property int btnRadius: root.context.config.fontSize * 1.5

        color: "transparent"

        // visible: context.overlayState.audioPanelOpen
        visible: context.overlayState.audioPanelOpen

        implicitHeight: Screen.height
        implicitWidth: Screen.width
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: context.overlayState.audioPanelOpen ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
        WlrLayershell.namespace: "audio-panel"
        WlrLayershell.exclusiveZone: -1

        margins.top: context.config.fontSize * 4
        anchors {
            top: true
            right: true
        }

        MouseArea {
            implicitWidth: Screen.width
            implicitHeight: Screen.height
            onClicked: {
                root.context.overlayState.closeAll();
            }
            onWheel: (wheel) => { 
                var step = 0.05;
                var next = (wheel.angleDelta.y > 0) ? audio.volume + step : audio.volume - step;
                next = Math.max(0, Math.min(1, next));
                audio.setVolume(next);
            }
        }

        FocusScope {
            id: eventHandler

            anchors.fill: parent
            focus: true
            Keys.onEscapePressed: context.overlayState.toggleVolumePanel()
            Keys.onUpPressed: audio.increaseVolume()
            Keys.onDownPressed: audio.decreaseVolume()
            Keys.onPressed: (event) => {
                const key = event.text.toUpperCase();
                if (key === "M") {
                    audio.toggleMute();
                    event.accepted = true;
                    return ;
                }

            }
        }

        Rectangle {
            id: panel
            x: context.overlayState.audioPanelOpen ? parent.width - implicitWidth : parent.width

            implicitHeight: mainColumn.implicitHeight + ( context.config.fontSize * 4 )
            implicitWidth: btnSize + ( context.config.fontSize * 4 )
            bottomLeftRadius: root.btnRadius
            topLeftRadius: root.btnRadius
            color: context.theme.bg

            Column {
                id: mainColumn

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: context.config.fontSize

                Elements.Slider {
                    icon: audio.icon
                    value: audio.volume
                    theme: context.theme
                    barRadius: btnRadius
                    barWidth: btnSize
                    fontSize: context.config.fontSize
                    fontFamily: context.config.fontFamily
                    onChangeRequested: (v) => {
                        return audio.setVolume(v);
                    }
                }
                
                Item {
                    id: mute

                    implicitHeight: root.btnSize
                    implicitWidth: root.btnSize

                    Rectangle {
                        anchors.fill: parent
                        color: context.audio.muted ? context.theme.focus_color : hoverMute.hovered ? context.theme.focus_color : context.theme.focus_muted
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
                            color: context.audio.muted ? context.theme.fg : hoverMute.hovered ? context.theme.fg : context.theme.bg
                            font.pixelSize: context.config.fontSize
                            font.family: context.config.fontFamily
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
                        onClicked: context.audio.toggleMute()
                    }
                }

                // Item {
                //     id: sinkBtn

                //     implicitHeight: btnSize
                //     implicitWidth: btnSize
                    
                //     Rectangle {
                //         anchors.fill: parent
                //         radius: btnRadius
                //         color: hoverSinks.hovered ? theme.mainAltColor : globalState.sinkPanelOpen ? theme.mainColor : theme.fgColor

                //         Text {
                //             anchors.centerIn: parent
                //             text: "󱡫"
                //             color: globalState.sinkPanelOpen ? theme.fgColor : theme.bgColor
                //             font.pixelSize: root.config.fontSize * 1.2
                //             font.family: root.config.fontFamily

                //             Behavior on color {
                //                 ColorAnimation {
                //                     duration: 300
                //                     easing.type: Easing.OutCubic
                //                 }
                //             }
                //         }

                //         HoverHandler {
                //             id: hoverSinks
                //         }

                //         MouseArea {
                //             anchors.fill: parent
                //             cursorShape: Qt.PointingHandCursor
                //             onClicked: root.globalState.toggleSinkPanel()
                //         }

                //         Behavior on color {
                //             ColorAnimation {
                //                 duration: 300
                //                 easing.type: Easing.OutCubic
                //             }
                //         }
                //     }
                // }

            }

            Behavior on x {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }

        Behavior on visible {
            NumberAnimation {
                duration: context.overlayState.audioPanelOpen ? 1500 : 0
                easing: Easing.OutCubic
            }
        }
    }
}