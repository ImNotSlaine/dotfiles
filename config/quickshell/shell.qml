import Quickshell
import qs.core
import qs.modules.corners

ShellRoot {
    id: root

    Context {
        id: ctx
    }

    ScreenCorners {
        context: ctx
    }
}