import QtQuick
import Quickshell
import Quickshell.Io
import qs.core
import qs.modules.panels

Item {
	id: root

	required property Context context

	// SysPanel {
	// 	id: sysPanel

	// 	config: root.context.config
	// 	globalState: root.context.appState
	// 	isOpen: root.context.appState.sysPanelOpen
	// 	theme: root.context.theme
	// }

	// IpcHandler {
	// 	function toggle() {
	// 		root.context.appState.toggleSysPanel();
	// 	}

	// 	target: "syspanel"
	// }

	AudioPanel {
		id: volumePanel

		context: root.context
	}

	IpcHandler {
		function toggle() {
			root.context.overlayState.toggleAudioPanel();
		}

		target: "audiopanel"
	}

	// SinkPanel {
	// 	id: sinkPanel

	// 	config: root.context.config
	// 	globalState: root.context.appState
	// 	isOpen: root.context.appState.sinkPanelOpen
	// 	theme: root.context.theme
	// 	sinks: root.context.volume.sinks
	// 	defaultSink: root.context.volume.sink
	// 	volume: root.context.volume
	// }

	// IpcHandler {
	// 	function toggle() {
	// 		root.context.appState.toggleSinkPanel();	
	// 	}

	// 	target: "sinkpanel"
	// }

}
