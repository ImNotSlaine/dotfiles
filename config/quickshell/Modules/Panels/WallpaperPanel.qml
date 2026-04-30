import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Core
import qs.Modules.Corners
import qs.Services

PanelWindow {
	id: root

	required property var globalState
	property bool internalOpen: false
	property int currentScreenIndex: 00
	property string wallpaperPath: WallpaperService.defaultDirectory
	property var wallpapersList: []
	property string currentWallpaper: ""

	function updateWallpaperData

	color: "transparent"
	visible: false	
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
	WlrLayershell.namespace: "wallpaper-panel"
	WlrLayershell.exclusiveZone: -1

	anchors {
		top: true
		bottom: true
		left: true
		right: true
	}
}
