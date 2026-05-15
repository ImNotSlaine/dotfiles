import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.Core
import qs.Widgets

PanelWindow {
	id: root

	required property var ctx
	property bool isOpen: false
	required property var globalState
	required property Theme colors
	required property int barHeight 
	property int currentIndex: 0
	readonly property int boxWidth: 300
	readonly property int itemHeight: 50
	readonly property int itemSpacing: 16
	readonly property int headerHeight: 40

	function runCommand(cmd) {
		if (cmd.includes("$USER"))
			cmd = cmd.replace("$USER", Quickshell.env("USER"));

		console.log("Power menu: Executing command:", cmd);
		Quickshell.execDetached(["sh", "-c", cmd]);
		globalState.powerMenuOpen = false;
	}


	visible: isOpen

	color: "transparent"

	implicitHeight: Screen.height
	implicitWidth: Screen.width
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.namespace: "system-panel"
	WlrLayershell.exclusiveZone: -1

	anchors {
		top: true
		left: true
		right: true
		bottom: true
	}

	Rectangle {
		id: panel

		property int contentWidth: itemHeight * 3 + itemSpacing * 2 + 72
		property int contentHeight: headerHeight + itemHeight * 2 + 24

		width: contentWidth
		height: contentHeight
		y: root.barHeight
		bottomRightRadius: root.itemSpacing
		color: root.colors.bgColor

		Column {
			id: sectionColumn

			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			spacing: root.itemSpacing

			Row {
				id: buttonsRow

				spacing: root.itemSpacing

				Item {
					id: powerOff

					implicitHeight: root.itemHeight
					implicitWidth: root.itemHeight

					Rectangle {
						anchors.fill: parent
						color: root.colors.fgColor
						radius: root.itemSpacing * 2

						Icon {
							anchors.centerIn: parent
							icon: ""
							color: root.colors.bgColor
							font.pixelSize: root.ctx.config.fontSize * 1.5
							
						}
					}
				}
				
				Item {
					id: logOut

					implicitHeight: root.itemHeight
					implicitWidth: root.itemHeight

					Rectangle {
						anchors.fill: parent
						color: root.colors.fgColor
						radius: root.itemSpacing * 2

						Icon {
							anchors.centerIn: parent
							icon: "󰍃"
							color: root.colors.bgColor
							font.pixelSize: root.ctx.config.fontSize * 1.5
							
						}
					}
				}

			}
		}

	}
}
