import QtQuick
import QtQuick.Layouts
import qs.Core
import qs.Services

Rectangle {
    id: root

    required property var theme
    required property var globalState
    required property var volume
    property string fontFamily: "Mononoki Nerd Font"
    property int fontSize: 16
    
    property string icon: volume.icon
    
    Layout.preferredHeight: fontSize * 2
    Layout.alignment: Qt.AlignVCenter
    Layout.bottomMargin: 2
    width: innerLayout.implicitWidth
    color: "transparent"

    RowLayout {
        id: innerLayout

        anchors.centerIn: parent
        spacing: 0
        width: parent.width

        HoverHandler {
            id: hoverHandler
        }

        Text {
            id: volText

            Layout.alignment: Qt.AlignVCenter
            height: innerLayout.implicitHeight
            text: icon
            font.pixelSize: fontSize
            color: hoverHandler.hovered ? root.theme.mainColor : root.theme.fgColor

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
        onClicked: root.globalState.toggleVolumePanel()
    }
}