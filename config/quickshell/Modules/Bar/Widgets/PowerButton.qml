import QtQuick
import QtQuick.Layouts
import qs.Core
import qs.Widgets

Rectangle {
	id: root

	required property var colors
	property string fontFamily: "Monospace"
	property int fontSize: 12

	Layout.preferredHeight: 30
	Layout.alignment: Qt.AlignVCenter
	implicitWidth: innerLayout.implicitWidth + 8
	radius: height / 2
	color: "transparent"

	RowLayout {
		id: innerLayout

		anchors.centerIn: parent
		spacing: 0
		width: parent.width

		HoverHandler {
			id: hoverHandler
		}

		Item {
			id: textContainer

			Layout.preferredWidth: 0
			Layout.preferredHeight: root.height
			clip: true

			Text {
				id: pwrText

				anchors.verticalCenter: parent.verticalCenter
				text: "Power"
				color: root.colors.fgColor
				font.pixelSize: root.fontSize
				font.family: root.fontFamily
				font.bold: true
			}

			TextMetrics {
				id: textMetrics

				font: pwrText.font
				text: pwrText.text
			}
		}

		Rectangle {
			Layout.preferredWidth: 24
			Layout.preferredHeight: 24
			radius: 12
			color: hoverHandler.hovered ? root.colors.mainColor : "transparent"
			border.color: root.colors.mainColor
			border.width: 2

			Behavior on color {
				ColorAnimation {
					duration: 200
					easing.type: Easing.OutCubic
				}
			}

			Icon {
				anchors.centerIn: parent
				icon: "⏻"
				color: hoverHandler.hovered ? root.colors.mainColor : root.colors.fgColor
				font.pixelSize: root.fontSize
			}

		}

		Item {
			Layout.preferredWidth: 4
		}
	}

	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
	}
}
