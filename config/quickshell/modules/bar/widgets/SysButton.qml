import QtQuick
import QtQuick.Layouts
import qs.core

Rectangle {
	id: root

    required property var context

	Layout.preferredHeight: context.config.fontSize * 2
	Layout.alignment: Qt.AlignVCenter
	Layout.bottomMargin: 2
	width: sysText.implicitWidth
	color: "transparent"


	HoverHandler {
		id: hoverHandler
	}
	
	Text {
		id: sysText

		anchors.centerIn: parent
		bottomPadding: 1
		text: "󰣇"
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
		// onClicked: root.globalState.toggleSysPanel()
	}
}
