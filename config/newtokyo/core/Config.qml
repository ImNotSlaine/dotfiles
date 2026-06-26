import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton

Singleton {
    id: root

    property string configPath: (Quickshell.env("HOME") + "/.dotfiles") + "/config/newtokyo/config.json"

    property string fontFamily: "Mononoki Nerd Font"
    property int fontSize: 14

    property bool floatBar: false
    
    property string wallpaperDir: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    
    property bool _loading: false

    function save() {
        if (_loading)

            return ;

		configAdapter.fontFamily = root.fontFamily;
		configAdapter.fontSize = root.fontSize;
		configAdapter.floatBar = root.floatBar;
        configAdapter.wallpaperDir = root.wallpaperDir;
		configFile.writeAdapter();
		Logger.d("Config", "Settings saved to " + root.configPath);
    }

	onFontFamilyChanged: {
		if (!_loading)
			saveTimer.restart();
	}

    onFloatBarChanged: {
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
            if(!root._loading) {
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

                if (configAdapter.floatBar)
                    root.floatBar = configAdapter.floatBar;

				if (configAdapter.wallpaperDir)
					root.wallpaperDir = configAdapter.wallpaperDir;

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
			property bool floatBar
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