import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.Core
import qs.Services

Rectangle {
	id: barRoot

	required property string fontFamily
	required property int fontSize
	required property Theme colors

	anchors.fill: parent
	color: colors.bgColor
	border.width: 0

	Text {
		anchors.centerIn: parent

		font.pixelSize: fontSize
		color: colors.fgColor
		text: "Hola"
	} 
	
}

