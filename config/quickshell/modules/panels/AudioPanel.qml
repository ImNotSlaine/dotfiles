import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.core
import qs.modules.corners
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

        property var current: context.audio.sink

        readonly property int btnSize: root.context.config.fontSize * 3
        readonly property int btnRadius: root.context.config.fontSize * 1.5

        color: '#3C000000'

        visible: context.overlayState.audioPanelOpen

        implicitHeight: Screen.height
        implicitWidth: Screen.width
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: context.overlayState.audioPanelOpen ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
        WlrLayershell.namespace: "audio-panel"
        WlrLayershell.exclusiveZone: -1

        margins.top: context.config.fontSize * 2
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
            y: context.config.fontSize * 2

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

                Item {
                    id: sinkBtn

                    implicitHeight: btnSize
                    implicitWidth: btnSize
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: btnRadius
                        color: hoverSinks.hovered ? context.theme.focus_color : context.overlayState.audioSinkPanelOpen ? context.theme.focus_color : context.theme.focus_muted

                        Text {
                            anchors.centerIn: parent
                            text: "󱡫"
                            color: hoverSinks.hovered ? context.theme.fg : context.overlayState.audioSinkPanelOpen ? context.theme.fg : context.theme.bg
                            font.pixelSize: context.config.fontSize * 1.2
                            font.family: context.config.fontFamily

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
                            onClicked: context.overlayState.toggleAudioSinkPanel()
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

            Behavior on x {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }

        RoundCorner {
            id: topConnector
            y: context.config.fontSize
            x: context.overlayState.audioPanelOpen ? parent.width - width : parent.width
            size: context.config.fontSize
            state: "active"
            corner: RoundCorner.CornerEnum.BottomRight
            color: context.theme.bg

            Behavior on x {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }

        RoundCorner {
            id: bottomConnector
            y: panel.height + context.config.fontSize * 2
            x: context.overlayState.audioPanelOpen ? parent.width - width : parent.width
            size: context.config.fontSize
            state: "active"
            corner: RoundCorner.CornerEnum.TopRight
            color: context.theme.bg

            Behavior on x {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }

        Rectangle {
            id: sinkPanel

            x: context.overlayState.audioSinkPanelOpen ? Screen.width - sinkPanel.width : Screen.width
            y: panel.height + context.config.fontSize * 6

            color: context.theme.bg
            width: sinksRow.width + context.config.fontSize * 4
            height: root.btnSize + context.config.fontSize * 4

            topLeftRadius: btnRadius
            bottomLeftRadius: btnRadius

            Row {
                id: sinksRow
                anchors.centerIn: parent
                spacing: context.config.fontSize

                Repeater {
                    model: context.audio.sinks

                    Rectangle {
                        required property var modelData
                        required property int index

                        implicitHeight: root.btnSize
                        implicitWidth: root.btnSize
                        radius: root.btnRadius

                        color:  if (audio.sink?.id == audio.sinks[index]?.id) {
                                    return context.theme.focus_color ;
                                } else if (hoverSink.hovered) {
                                    return context.theme.focus_color ;
                                } else {
                                    return context.theme.focus_muted ;
                                }

                        visible: true

                        Behavior on color {
                            ColorAnimation {
                                duration: 300
                                easing.type: Easing.OutCubic
                            }
                        }

                        Text {
                            text: if (audio.sinks[index].name.match("hdmi")) {
                                return "" ;
                            } else {
                                return "" ;
                            }

                            color: if (audio.sink?.id == audio.sinks[index]?.id) {
                                return context.theme.fg ;
                            } else if (hoverSink.hovered) {
                                return context.theme.fg ;
                            } else {
                                return context.theme.bg ;
                            }

                            anchors.centerIn: parent
                            font.pixelSize: context.config.fontSize
                            font.family: context.config.fontFamily

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
                            onClicked: context.audio.setDefaultSink(context.audio.sinks[index])
                        }
                    
                        HoverHandler {
                            id: hoverSink
                        }

                    }
                }
            }

            Behavior on x {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }

        RoundCorner {
            id: topConnectorSink
            y: context.config.fontSize + panel.height + context.config.fontSize * 4
            x: context.overlayState.audioSinkPanelOpen ? Screen.width - size : Screen.width 
            size: context.config.fontSize
            state: "active"
            corner: RoundCorner.CornerEnum.BottomRight
            color: context.theme.bg

            Behavior on x {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }

        RoundCorner {
            id: bottomConnectorSink
            y: panel.height + context.config.fontSize * 6 + sinkPanel.height
            x: context.overlayState.audioSinkPanelOpen ? parent.width - width : parent.width
            size: context.config.fontSize
            state: "active"
            corner: RoundCorner.CornerEnum.TopRight
            color: context.theme.bg

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