import QtQuick

QtObject {
	id: root

	property bool sysPanelOpen: false

	function toggleSysPanel() {
		if (sysPanelOpen) {
			sysPanelOpen = false;
		} else {
			sysPanelOpen = true;
		}
	}

	function closeAll() {
		sysPanelOpen = false;
	}
}
