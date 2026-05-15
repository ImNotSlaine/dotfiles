import QtQuick
import qs.Core
import qs.Services

Item {
	id: root

	property var config: Config
	property alias theme: themeService
	property alias time: timeService

	Theme {
		id: themeService
	}

	TimeService {
		id: timeService
	}

}
