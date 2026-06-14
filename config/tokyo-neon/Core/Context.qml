import QtQuick
import qs.Core
import qs.Services

Item {
	id: root

	property var config: Config
	property alias theme: themeService
	property alias appState: appStateService
	property alias time: timeService
	property var volume: VolumeService

	Theme {
		id: themeService
	}

	GlobalState {
		id: appStateService
	}

	TimeService {
		id: timeService
	}

}
