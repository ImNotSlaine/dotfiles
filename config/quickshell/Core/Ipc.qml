import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
	id: root

	signal dirCreationFinished(int code)

	function createDirs() {
		dirCreator.running = true;
	}

	Process {
		id: dirCreator

		command: ["mkdir", "-p", Quickshell.env("HOME") + "/.cache/neonpunk"]
		running: false
		onExited: (code, status) => {
			return root.dirCreationFinished(code);
		}
	}
}
