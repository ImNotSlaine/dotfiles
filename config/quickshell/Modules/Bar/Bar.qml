import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.Core
import qs.Services
import qs.Modules.Bar.Widgets

Rectangle {
	id: barRoot

	required property string fontFamily
	required property int fontSize
	required property Theme colors

	anchors.fill: parent
	color: colors.bgColor
	border.width: 0

	RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 16
		anchors.rightMargin: 16
		spacing: 12

		PowerButton {
			colors: barRoot.colors
			fontFamily: barRoot.fontFamily
			fontSize: barRoot.fontSize
		}
	}
}

