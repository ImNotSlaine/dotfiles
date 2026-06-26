import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Core
import qs.Services

Rectangle {
    id: wsContainer

    required property var theme
    property string fontFamily: "Mononoki Nerd Font"
    property int fontSize: 16

    property var hyprService

    Layout.alignment: Qt.AlignVCenter
    
    color: "black"

    height: 20
    width: 200

    Text {
        text: hyprService.ws.values.id
        color: "white"
    }
}