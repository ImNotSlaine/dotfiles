import QtQuick
import QtQuick.Layouts
import qs.core

Rectangle {
	required property var context
	
	height: context.config.fontSize * 2
	width: clock.implicitWidth
	color: "transparent"

	Text {
		id: clock
		anchors.centerIn: parent
		font.family: context.config.fontFamily
		font.pixelSize: context.config.fontSize
		text: "  " + context.time.currentTime + " "
		color: context.theme.fg
	}
}
