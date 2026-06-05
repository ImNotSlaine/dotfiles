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
}
