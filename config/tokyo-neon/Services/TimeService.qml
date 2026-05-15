import QtQuick
import qs.Core

Item {
	property string currentTime: Qt.formatDateTime(new Date(), Config.use24HourFormat ? "HH:mm" : "hh:mm AP")

	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: currentTime = Qt.formatDateTime(new Date(), Config.use24HourFormat ? "HH:mm" : "hh:mm AP")
	}
}
