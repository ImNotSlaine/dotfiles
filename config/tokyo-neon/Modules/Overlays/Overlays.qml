import QtQuick
import Quickshell
import Quickshell.Io
import qs.Core
import qs.Modules.Panels

Item {
	id: root

	required property Context context

	SysPanel {
		id: sysPanel

		config: root.context.config
		globalState: root.context.appState
		isOpen: root.context.appState.sysPanelOpen
		theme: root.context.theme
	}

	IpcHandler {
		function toggle() {
			root.context.appState.toggleSysPanel();
		}

		target: "syspanel"
	}

	VolumePanel {
		id: volumePanel

		config: root.context.config
		globalState:  root.context.appState
		isOpen: root.context.appState.volumePanelOpen
		theme: root.context.theme
		volume: root.context.volume
	}

	IpcHandler {
		function toggle() {
			root.context.appState.toggleVolumePanel();
		}

		target: "volumepanel"
	}

	SinkPanel {
		id: sinkPanel

		config: root.context.config
		globalState: root.context.appState
		isOpen: root.context.appState.sinkPanelOpen
		theme: root.context.theme
		sinks: root.context.volume.sinks
		defaultSink: root.context.volume.sink
		volume: root.context.volume
	}

	IpcHandler {
		function toggle() {
			root.context.appState.toggleSinkPanel();	
		}

		target: "sinkpanel"
	}

}
