import QtQuick
import QtQuick.Layouts
import qs.Core

Rectangle {
	required property var theme
	property string fontFamily: "Mononoki Nerd Font"

	required property string time
	property int fontSize: 16

	height: 26
	width: clockText.implicitWidth
	color: "transparent"

	Text {
		id: clockText
		anchors.centerIn: parent
		font.family: fontFamily
		font.pixelSize: fontSize
		text: " " + time
		color: theme.fgColor
	}
}
