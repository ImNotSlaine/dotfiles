import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Core
import qs.Services

Item {
	id: root

	property string source: ""
	property Image currentImage: img1
	property int transitionType: 0
	property string screenName: screen ? screen.name : ""

	anchors.fill: parent

	Component.onCompleted: {
		if (WallpaperService.isInitialized) {
			var wallpaper = WallpaperService.getWallpaper(screenName);
			if (wallpaper && wallpaper !== "")
				root.source = "file://" + wallpaper;
		}

	}

	Connections {
		function onIsInitializedChanged() {
			if (WallpaperService.isInitialized && !root.source) {
				var wallpaper = WallpaperService.getWallpaper(screenName);
				if (wallpaper && wallpaper !== "") {
					Logger.d("Wallpaper", "Loading initial wallpaper for", screenName, ":", wallpaper);
					root.source = "file://" + wallpaper;
				}
			}
		}

		target: WallpaperService
	}

	Rectangle {
		anchors.fill: parent
		color: "#1e1e2e"
		visible: root.source === "" && WallpaperService.isInitialized
		z: 10

		ColumnLayout {
			anchors.centerIn: parent
			spacing: 20

			Text {
				text: "Sin wallpaper"
			}
		}
	}

	Item {
		id: img1Container

		anchors.fill: parent

		Image {
			id: img1

			anchors.fill: parent
			fillMode: Image.PreserveAspectCrop
			asynchronous: true
			cache: true
			smooth: true
			opacity: (root.currentImage === img1) ? 1 : 0
			onStatusChanged: {
				if (status === Image.Ready && root.currentImage !== img1 && source == root.source)
					Qt.callLater(function() {
						applyTransition(img1, img2);
					});
			}
		}
	}

	Item {
		id: img2Container

		anchors.fill: parent

		Image {
			id: img2

			anchors.fill: parent
			fillMode: Image.PreserveAspectCrop
			asynchronous: true
			cache: true
			smooth: true
			opacity: (root.currentImage === img2) ? 1 : 0
			onStatusChanged: {
				if (status === Image.Ready && root.currentImage !== img2 && source == root.source)
				Qt.callLater(function() {
					applyTransition(img2, img1);
				});
			}
		}
	}
}
