import Quickshell
import qs.core
import qs.modules.corners
import qs.modules.bar

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