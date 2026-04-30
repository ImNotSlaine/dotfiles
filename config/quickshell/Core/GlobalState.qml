import QtQuick

QtObject {
	id: root

	property bool wallpaperPanelOpen: false

	function toggleWallpaperPanel() {
		if (wallpaperPanelOpen) {
			wallpaperPanelOpen = false;
		} else {
			closeAll();
			wallpaperPanelOpen = true;
		}
	}

	function closeAll() {
		wallpaperPanelOpen = false;
	}
}
