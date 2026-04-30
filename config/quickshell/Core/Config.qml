import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
	id: root

	property string configPath: (Quickshell.env("XDG_CONFIG_HOME") || (Quickshell.env("HOME") + "/.config")) + "/quickshell/config.json"
	property string fontFamily: "Mononoki Nerd Font"
	property int fontSize: 14
	property string wallpaperDirectory: Quickshell.env("HOME") + "/Pictures/Wallpapers"
	property int barHeight: 30
	property bool _loading: false

	function save() {
		if (_loading)

			return ;

		configAdapter.fontFamily = root.fontFamily;
		configAdapter.fontSize = root.fontSize;
		configAdapter.wallpaperDirectory = root.wallpaperDirectory;
		configAdapter.barHeight = root.barHeight;	
		configFile.writeAdapter();
		Logger.d("Config", "Settings saved to " + root.configPath);
	}

	onFontFamilyChanged: {
		if (!_loading)
			saveTimer.restart();
	}
	
	onFontSizeChanged: {
		if (!_loading)
			saveTimer.restart();
	}

	onWallpaperDirectoryChanged: {
		if (!_loading)
			saveTimer.restart();
	}

	onBarHeightChanged: {
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
	
				if (configAdapter.fontSize)
					root.fontSize = configAdapter.fontSize;

				if (configAdapter.wallpaperDirectory)
					root.wallpaperDirectory = configAdapter.wallpaperDirectory
				
				if (configAdapter.barHeight)
					root.barHeight = configAdapter.barHeight;

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
			property string wallpaperDirectory
			property int barHeight
		}
	}

	Timer {
		id: saveTimer

		interval: 1000
		repeat: false
		onTriggered: root.save()
	}

}
