import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.core
import qs.modules.bar.widgets

Rectangle {
	id: barRoot

	required property var context

	anchors.fill: parent
	color: context.theme.bg
	border.width: 0

	//Workspaces {
	//	context: barRoot.context
	//}

	RowLayout {
		anchors.fill: parent
		anchors.leftMargin: barRoot.context.config.fontSize
		anchors.rightMargin: barRoot.context.config.fontSize
		spacing: barRoot.context.config.fontSize
		
		SysButton {
			context: barRoot.context
        }

		Clock {
            context: barRoot.context
		}

		Item {
			Layout.fillWidth: true
		}

		Item {
			Layout.fillWidth: true
		}

		AudioButton {
			context: barRoot.context
		}

//		Workspaces {
//			theme: barRoot.theme
//			fontFamily: barRoot.fontFamily
//			fontSize: barRoot.fontSize
//			hyprService: barRoot.context.hypr
//		}

	}

}
