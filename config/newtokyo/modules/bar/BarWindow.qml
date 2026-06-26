import QtQuick
import Quickshell
import qs.core
import qs.modules.bar

Variants {
	id: root
	model: Quickshell.screens
	required property Context context

	PanelWindow {
		property var modelData

		screen: modelData

		visible: true
		implicitHeight: root.context.config.fontSize * 2
		color: "transparent"

		anchors {
			top: true
			left: true
			right: true
		}

		Bar {
			context: root.context
		}

		Behavior on implicitHeight {
			NumberAnimation {
				duration: 300
				easing.type: Easing.OutQuad
			}
		}
	}
}
