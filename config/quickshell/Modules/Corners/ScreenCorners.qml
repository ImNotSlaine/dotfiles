import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Core

Variants {
	id: screenCorners

	property Context context

	model: Quickshell.screens
	
	PanelWindow {
		property var modelData
		property int barHeight: context.config.barHeight
		property int cornerSize: 25

		screen: modelData
		visible: true
		color: "transparent"
		exclusionMode: ExclusionMode.Ignore
		WlrLayershell.namespace: "quickshell:screenCorners"
		WlrLayershell.layer: WlrLayer.Overlay
	
		anchors {
			top: true
			left: true
			right: true
			bottom: true
		}
	
		RoundCorner {
			id: topLeft
	
			property real verticalSnap: 0
	
			size: cornerSize
			anchors.left: parent.left
			state: "active"
			anchors.top: parent.top
			anchors.topMargin: barHeight * verticalSnap
			corner: RoundCorner.CornerEnum.TopLeft
			color: context.theme.bgColor
			anchors.leftMargin: 0
	
			states: State {
				name: "active"
	
				PropertyChanges {
					target: topLeft
					anchors.leftMargin: 0
					verticalSnap: 1
				}
			}
		}
	
		mask: Region {
			item: null
		}
	}
}
