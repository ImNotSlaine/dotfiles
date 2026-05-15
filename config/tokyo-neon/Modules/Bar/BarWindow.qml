import QtQuick
import Quickshell
import qs.Core
import qs.Modules.Bar

Variants {
	id: root
	model: Quickshell.screens
	required property Context context

	PanelWindow {
		property var modelData

		screen: modelData

		visible: true
		implicitHeight: root.context.config.barSize
		color: "transparent"

		anchors {
			top: true
			left: true
			right: true
		}

		Bar {
			theme: root.context.theme
			fontFamily: root.context.config.fontFamily
			fontSize: root.context.config.fontSize

			time: root.context.time.currentTime
		}

		Behavior on implicitHeight {
			NumberAnimation {
				duration: 300
				easing.type: Easing.OutQuad
			}
		}
	}
}
