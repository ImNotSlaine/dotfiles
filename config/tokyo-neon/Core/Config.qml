import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
	id: root

	property string configPath: (Quickshell.env("XDG_CONFIG_HOME") || (Quickshell.env("HOME") + "/.config")) + "/tokyo-neon/config.json"

	property string wallpaperDir: Quickshell.env("HOME") + "/Pictures/Wallpapers"
	property string fontFamily: "Mononoki Nerd Font"
	property int barSize: fontSize * 2
	property bool _loading: false
	property int fontSize: 16

	function save() {
		if (_loading)
		
			return ;

		configAdapter.fontFamily = root.fontFamily;
		configAdapter.wallpaperDir = root.wallpaperDir;
		configAdapter.fontSize = root.fontSize;
		configFile.writeAdapter();
		Logger.d("Config", "Settings saved to " + root.configPath);
	}

	onFontFamilyChanged: {
		if (!_loading)
			saveTimer.restart();
	}

	onBarSizeChanged: {
		if (!_loading)
			saveTimer.restart();
	}

	onFontSizeChanged: {
		if (!_loading)
			saveTimer.restart();
	}

	onWallpaperDirChanged: {
		if (!_loading)
			saveTimer.restart();
	}

	FileView {
		id: configFile

		path: root.configPath
		watchChanges: true
		onFileChanged: {
			if (!root._loading) {
				Logger.d("Config", "Config file changed externally, reloading...");
				configFile.reload();
			}
		}

		onLoaded: {
			root._loading = true;
			try {
				if (configAdapter.fontFamily)
					root.fontFamily = configAdapter.fontFamily;

				if (configAdapter.wallpaperDir)
					root.wallpaperDir = configAdapter.wallpaperDir;

				if (configAdapter.fontSize)
					root.fontSize = configAdapter.fontSize;

				Logger.i("Config", "Loaded from " + root.configPath);
			} catch (e) {
				Logger.e("Config", "Failed to apply config: " + e);
			}
			root._loading = false;
		}

		adapter: JsonAdapter {
			id: configAdapter

			property string fontFamily
			property int fontSize
			property string wallpaperDir
		}
	}

	Timer {
		id: saveTimer
		
		interval: 1000
		repeat: false
		onTriggered: root.save()
	}
}
