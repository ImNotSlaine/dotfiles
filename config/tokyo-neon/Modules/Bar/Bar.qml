import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.Core
import qs.Modules.Bar.Widgets

Rectangle {
	id: barRoot

	required property string fontFamily
	required property int fontSize
	required property Theme theme
	required property string time

	anchors.fill: parent
	color: theme.bgColor
	border.width: 0

	RowLayout {
		anchors.fill: parent
		anchors.leftMargin: fontSize
		anchors.rightMargin: fontSize
		spacing: fontSize
		
		SysButton {
			theme: barRoot.theme
			fontFamily: barRoot.fontFamily
			fontSize: barRoot.fontSize
		}

		Clock {
			theme: barRoot.theme
			fontFamily: barRoot.fontFamily
			fontSize: barRoot.fontSize
			time: barRoot.time
		}

		Item {
			Layout.fillWidth: true
		}
	}

}
