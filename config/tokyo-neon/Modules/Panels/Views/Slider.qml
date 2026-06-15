import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property string icon: ""
    property real value: 0
    property int barRadius
    property int barWidth
    required property var theme

    property string fontFamily
    property int fontSize

    signal changeRequested(real newValue)

    implicitHeight: barWidth * 5
    implicitWidth: barWidth
    radius: barRadius

    color: "transparent"

    Slider {
        id: slider

        Layout.fillHeight: true
        orientation: Qt.Vertical
        from: 0
        value: value
        to: 1
        onMoved: root.changeRequested(value)
        snapMode: Slider.SnapOnRelease
        stepSize: 0.05

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            cursorShape: Qt.PointingHandCursor
            onWheel: (wheel) => {
                var step = 0.05;
                var next = (wheel.angleDelta.y > 0) ? slider.value + step : slider.value - step;
                next = Math.max(0, Math.min(1, next));
                root.changeRequested(next);
            }
        }

        Binding on value {
            value: root.value
            when: !slider.pressed
            restoreMode: Binding.RestoreBinding
        }

        background: Rectangle {
            y: parent.height - height
            implicitHeight: barWidth * 5
            implicitWidth: barWidth
            width: parent.width
            height: slider.height
            color: theme.mainAltColor
            radius: barRadius
            
            Rectangle {
                width: parent.width
                height: sliderHandler.height + (slider.visualPosition * (slider.availableHeight - sliderHandler.height)) - 1
                color: theme.fgColor
                radius: barRadius
            }
        }

        handle: Rectangle {
            id: sliderHandler
            y: slider.visualPosition * (slider.availableHeight - height)
            implicitHeight: barWidth
            implicitWidth: barWidth
            radius: barRadius
            color: handleHover.hovered ? theme.mainColor : theme.mainAltColor

            Behavior on color {
                ColorAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }

            Text {
                text: icon
                color: handleHover.hovered ? theme.fgColor : theme.bgColor
                anchors.centerIn: parent
                leftPadding: -3
                topPadding: -1
                font.pixelSize: fontSize

                Behavior on color {
                    ColorAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
            }

            HoverHandler {
                id: handleHover
            }
        }
    }
}