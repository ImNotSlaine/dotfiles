import Quickshell
import qs.Core
import qs.Modules.Bar

ShellRoot {
	id: root

	Context {
		id: ctx
	}

	BarWindow {
		context: ctx
	}
}
