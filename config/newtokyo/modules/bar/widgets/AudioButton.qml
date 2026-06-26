import QtQuick
import QtQuick.Layouts
import qs.core
import qs.services

Rectangle {
    id: root

    required property var context
    
    property string icon: context.audio.icon
    
    height: context.config.fontSize * 2
    width: volText.implicitWidth
    color: "transparent"

    HoverHandler {
        id: hoverHandler
    }

    Text {
        id: volText

        text: icon + "  "
        font.pixelSize: context.config.fontSize
        color: hoverHandler.hovered ? context.theme.focus_color : context.theme.focus_muted

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
        // onClicked: root.globalState.toggleVolumePanel()
    }
}