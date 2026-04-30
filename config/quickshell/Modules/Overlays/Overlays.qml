import QtQuick
import Quickshell
import Quickshell.Io
import qs.Core
import qs.Modules.Panels
import qs.Services

Item {
	id: root

	required property Context context

	WallpaperPanel {
		id: wallpaperPanel

		globalState: root.context.appState
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
