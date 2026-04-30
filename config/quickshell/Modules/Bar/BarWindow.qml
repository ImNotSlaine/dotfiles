import QtQuick
import Quickshell
import qs.Core
import qs.Modules.Bar

Variants {
	id: root

	required property Context context

	model: Quickshell.screens

	PanelWindow {
		property var modelData

		screen: modelData
		visible: true
		implicitHeight: root.context.config.barHeight
		color: "transparent"

		anchors {
			top: true
			left: true
			right: true
		}

		Bar {
			colors: root.context.theme
			fontFamily: root.context.config.fontFamily
			fontSize: root.context.config.fontSize
		}

		Behavior on implicitHeight {
			NumberAnimation {
				duration: 300
				easing.type: Easing.OutQuad
			}
		}
	}
}
