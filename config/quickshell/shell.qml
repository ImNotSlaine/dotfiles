import Quickshell
import qs.core
import qs.modules.corners

ShellRoot {
    id: root

    Context {
        id: ctx
    }

    BarWindow {
        context: ctx
    }

    ScreenCorners {
        context: ctx
    }
}