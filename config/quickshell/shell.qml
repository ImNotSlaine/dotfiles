import Quickshell
import qs.Core
import qs.Modules.Bar
import qs.Modules.Background
import qs.Modules.Corners
import qs.Modules.Overlays
import qs.Services

ShellRoot {
	id: root

	Context {
		id: ctx
	}

/*	Background {
	}
	*/
	Overlays {
		context: ctx
	}

	BarWindow {
		context: ctx
	}

	ScreenCorners {
		context: ctx
	}
}
