import QtQuick
import QtQuick.Layouts
import qs.Core

Rectangle {
	id: root

	required property var theme
	property string fontFamily: "Mononoki Nerd Font"
	property int fontSize: 16

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
			id: sysText

			Layout.alignment: Qt.AlignVCenter
			height: innerLayout.implicitHeight
			text: "󰣇"
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
	}
}
