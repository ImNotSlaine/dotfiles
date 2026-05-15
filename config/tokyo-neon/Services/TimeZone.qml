import QtQuick
import Quickshell
import Quickshell.Io

Item {
	id: root

	property var timeZones: []
	property string currentSysZone: ""
	property bool isLoading: true

	function setTimeZone(zone) {
		if (zone && zone !== currentSysZone) {
			setZoneProc.targetZone = zone;
			setZoneProc.running = true;
		}
	}

	Process {
		id: listZonesProc

		property string output: ""

		command: ["sh", "-c", "timedatectl list-timezones"]
		Component.onCompleted: running = true
		onExited: (code) => {
			if (code === 0 && output.length > 0) {
				var zones = output.trim().split("\n").filter((z) => {
					return z.length > 0;
				});
				root.timeZones = zones;
				root.isLoading = false;
			}
		}
	}
}
