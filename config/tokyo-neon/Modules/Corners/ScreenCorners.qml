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
		property int marginTop: context.config.barSize

		screen: modelData
	}
}
