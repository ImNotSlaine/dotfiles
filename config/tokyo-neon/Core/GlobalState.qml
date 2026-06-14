import QtQuick

QtObject {
	id: root

	property bool sysPanelOpen: false
	property bool volumePanelOpen: false

	function toggleSysPanel() {
		if (sysPanelOpen) {
			sysPanelOpen = false;
		} else {
			closeAll();
			sysPanelOpen = true;
		}
	}

	function toggleVolumePanel() {
		if (volumePanelOpen) {
			volumePanelOpen = false;
		} else {
			closeAll();
			volumePanelOpen = true;
		}
	}

	function closeAll() {
		sysPanelOpen = false;
	}
}
