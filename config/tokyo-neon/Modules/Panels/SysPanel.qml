import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.Core

PanelWindow {
	id: root

	property bool isOpen: false
	required property var config
	required property var globalState
	required property Theme theme

	readonly property int powerBtnSize: root.config.fontSize * 3
	readonly property int powerBtnRadius: root.config.fontSize * 1.5

	visible: isOpen

	color: "transparent"

	implicitHeight: 300
	implicitWidth: 300
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.namespace: "system-panel"
	WlrLayershell.exclusiveZone: -1

	margins.top: config.barSize
	anchors {
		top: true
		left: true
	}

	FocusScope {
		id: eventHandler

		anchors.fill: parent
	}

	Rectangle {
		id: panel

		width: 300
		height: 300

		bottomRightRadius: root.powerBtnRadius
		color: root.theme.bgColor

		Column {
			id: mainColumn

			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			spacing: 12

			Row {
				id: powerButtons

				Item {
					id: powerOff

					implicitHeight: root.powerBtnSize
					implicitWidth: root.powerBtnSize

					HoverHandler {
						id: hoverPowerOff
					}
					
					Rectangle {
						anchors.fill: parent
						color: root.theme.fgColor
						radius: root.powerBtnRadius

						Text {
							anchors.centerIn: parent
							text: ""
							color: root.theme.bgColor
							font.pixelSize: root.config.fontSize
							font.bold: true
						}
					}

					MouseArea {
						anchors.fill: parent
						cursorShape: Qt.PointingHandCursor
					}
				}
			}
		}
	}
	
}
