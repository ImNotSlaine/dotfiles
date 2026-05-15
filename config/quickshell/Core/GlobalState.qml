import QtQuick

QtObject {
	id: root

	property bool wallpaperPanelOpen: false
	property bool sysPanelOpen: false

	function toggleWallpaperPanel() {
		if (wallpaperPanelOpen) {
			wallpaperPanelOpen = false;
		} else {
			closeAll();
			wallpaperPanelOpen = true;
		}
	}

	function toggleSysPanel() {
		if (sysPanelOpen) {
			sysPanelOpen = false;
		} else {
			sysPanelOpen = true;
		}
	}

	function closeAll() {
		wallpaperPanelOpen = false;
		sysPanelOpen = false;
	}
}
