import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.Core
import qs.Services
import qs.Modules.Bar.Widgets

Rectangle {
	id: barRoot

	required property string fontFamily
	required property int fontSize
	required property Theme theme
	required property var globalState
	required property var context

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
			globalState: barRoot.globalState
		}

		Clock {
			theme: barRoot.theme
			fontFamily: barRoot.fontFamily
			fontSize: barRoot.fontSize
			time: barRoot.context.time.currentTime
		}

		Item {
			Layout.fillWidth: true
		}

//		Workspaces {
//			theme: barRoot.theme
//			fontFamily: barRoot.fontFamily
//			fontSize: barRoot.fontSize
//			hyprService: barRoot.context.hypr
//		}

		Volume {
			theme: barRoot.theme
			fontFamily: barRoot.fontFamily
			fontSize: barRoot.fontSize
			globalState: barRoot.globalState
			volume: barRoot.context.volume
		}
	}

}
