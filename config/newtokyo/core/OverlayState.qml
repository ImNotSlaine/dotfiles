import QtQuick

QtObject {
	id: root

	property bool sysPanelOpen: false
	property bool audioPanelOpen: false
	property bool audioSinkPanelOpen: false

	function toggleSysPanel() {
		if (sysPanelOpen) {
			sysPanelOpen = false;
		} else {
			closeAll();
			sysPanelOpen = true;
		}
	}

	function toggleAudioPanel() {
		if (audioPanelOpen) {
			audioPanelOpen = false;
		} else {
			closeAll();
			audioPanelOpen = true;
		}
	}

	function toggleAudioSinkPanel() {
		if (audioSinkPanelOpen) {
			audioSinkPanelOpen = false;
		} else {
			audioSinkPanelOpen = true;
		}
	}

	function closeAll() {
		sysPanelOpen = false;
		audioPanelOpen = false;
	}
}
