import Quickshell
import qs.Core
import qs.Modules.Bar
import qs.Modules.Corners
import qs.Modules.Overlays

ShellRoot {
	id: root

	Context {
		id: ctx
	}

	BarWindow {
		context: ctx
	}

	Overlays {
		context: ctx
	}

	ScreenCorners {
		context: ctx
	}
}
