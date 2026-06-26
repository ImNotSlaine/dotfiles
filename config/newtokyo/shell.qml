import Quickshell
import qs.core
import qs.modules.bar
import qs.modules.corners
import qs.modules.overlay

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

    Overlay {
        context: ctx
    }
}