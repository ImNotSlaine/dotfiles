import QtQuick
import Quickshell
import Quickshell.Io
import qs.Core
import qs.Modules.Panels
import qs.Services

Item {
	id: root

	required property Context context

	SysPanel {
		id: sysPanel

		ctx: context
		barHeight: root.context.config.barHeight
		globalState: root.context.appState
		isOpen: root.context.appState.sysPanelOpen
		colors: root.context.theme
	}

	IpcHandler {
		function toggle() {
			root.context.appState.toggleSysPanel();
		}

		target: "syspanel"
	}

	IpcHandler {
		function toggle() {
			root.context.appState.toggleWallpaperPanel();
		}

		target: "wallpaperpanel"
	}

	IpcHandler {
		function set(path: string) {
			WallpaperService.changeWallpaper(path, undefined);
		}

		target: "wallpaper"
	}
}
