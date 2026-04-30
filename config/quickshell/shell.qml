import Quickshell
import qs.Core
import qs.Modules.Bar
import qs.Modules.Background
import qs.Modules.Corners
import qs.Services

ShellRoot {
	id: root

	Context {
		id: ctx
	}

	Background {
	}

	BarWindow {
		context: ctx
	}

	ScreenCorners {
		context: ctx
	}
}
