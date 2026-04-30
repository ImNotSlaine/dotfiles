import Qt.labs.folderlistmodel
import QtQuick
import Quickshell
import Quickshell.Io
import qs.Core
import qs.Services
pragma Singleton

Singleton {
	id: root

	property string defaultDirectory: Config.wallpaperDirectory
	property var currentWallpapers: ({
	})
	property var wallpaperLists: ({
	})
	property int scanningCount: 0
	readonly property bool scanning: (scanningCount > 0)
	property bool isInitialized: false
	property string wallpaperCacheFile: Quickshell.env("HOME") + "/.cache/neonpunk/wallpapers.json"
	property string defaultWallpaper: "" 

	signal wallpaperChanged(string screenName, string path)
	signal wallpaperListChanged(string screenName, int count)
	
	function init() {
		Logger.i("Wallpaper", "Starting service");
		Ipc.createDirs();
		Qt.callLater(loadFromCache);
		Qt.callLater(refreshWallpapersList);
	}

	function loadFromCache() {
		wallpaperCacheView.path = wallpaperCacheFile;
	}

	function changeWallpaper(path, screenName) {
		if (screenName !== undefined) {
			_setWallpaper(screenName, path);
		} else {
			for (var i = 0; i < Quickshell.screens.length; i++) {
				_setWallpaper(Quickshell.screens[i].name, path);
			}
		}
	}

	function getWallpaper(screenName) {
		return currentWallpapers[screenName] || root.defaultWallpaper;
	}

	function _setWallpaper(screenName, path) {
		if (path === "" || path === undefined)
			return ;

		if (screenName === undefined) {
			Logger.w("Wallpaper", "No screen specified");
			return ;
		}
		var oldPath = currentWallpapers[screenName] || "";
		currentWallpapers[screenName] = path;
		saveTimer.restart();
		root.wallpaperChanged(screenName, path);
		Logger.d("Wallpaper", "Set wallpaper for", screenName, "to", path);
	}

	function getWallpaperList(screenName) {
		if (screenName !== undefined && wallpaperLists[screenName] !== undefined)
			return wallpaperLists[screenName];

		return [];
	}

	function refreshWallpapersList() {
		Logger.d("Wallpaper", "Refreshing wallpapers list");
		scanningCount = 0;
		for (var i =0; i < wallpaperScanners.count; i++) {
			var scanner = wallpaperScanners.objectAt(i);
			if (scanner)
				(function(s) {
					var directory = root.defaultDirectory;
					s.currentDirectory = "/tmp";
					Qt.callLater(function() {
						s.currentDirectory = directory;
					});
				})(scanner);
		}
	}

	Component.onCompleted: init()

	FileView {
		id: wallpaperCacheView

		path: ""
		onLoaded: {
			root.currentWallpapers = wallpaperCacheAdapter.wallpapers || {
			};
			root.defaultWallpaper = wallpaperCacheAdapter.defautlWallpaper || "";
			Logger.i("Wallpaper", "Loaded wallpapers from cache:", Object.keys(root.currentWallpapers).length, "screens");
			var screens = Object.keys(root.currentWallpapers);
			root.isInitialized = true;
		}
		onLoadFailed: (error) => {
			Logger.d("Wallpaper", "Cache not found, starting refresh");
			root.currentWallpapers = {
			};
			root.isInitialized = true;
		}

		adapter: JsonAdapter {
			id: wallpaperCacheAdapter

			property var wallpapers: ({
			})
			property string defaultWallpaper: ""
		}
	}

	Timer {
		id: saveTimer

		interval: 500
		repeat: false
		onTriggered: {
			wallpaperCacheAdapter.wallpapers = root.currentWallpapers;
			wallpaperCacheAdapter.defaultWallpaper = root.defaultWallpaper;
			wallpaperCacheView.writeAdapter();
			Logger.d("Wallpaper", "Saved wallpaper to cache");
		}
	} 

	Instantiator {
		id: wallpaperScanners

		model: Quickshell.screens

		delegate: FolderListModel {
			property string screenName: modelData.name
			property string currentDirectory: root.defaultDirectory

			folder: "file://" + currentDirectory
			nameFilters: ["*.jpg"]
			showDirs: false
			sortField: FolderListModel.Name
			onCurrentDirectoryChanged: folder = "file://" + currentDirectory
			onStatusChanged: {
				if (status === FolderListModel.Null) {
					root.wallpaperLists[screenName] = [];
					root.wallpaperListChanged(screenName, 0);
				} else if (status === FolderListModel.Loading) {
					root.wallpaperLists[screenName] = [];
					scanningCount++;
				} else if (status === FolderListModel.Ready) {
					var files = [];
					for (var i = 0; i < count; i++) {
						var directory = root.defaultDirectory;
						var fp = directory + "/" + get(i, "fileName");
						files.push(fp);
					}
					root.wallpaperLists[screenName] = files;
					scanningCount--;
					Logger.d("Wallpaper", "Refreshed:", screenName, "count:", files.length);
					root.wallpaperListChanged(screenName, files.length);
				}
			}
		}
	}

}
