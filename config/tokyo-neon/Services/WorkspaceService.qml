import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Item {
    id: root

    property int activeWorkspace: focusedWorkspaceId

    readonly property var focusedWorkspace: Hyprland.focusedWorkspace
    readonly property int focusedWorkspaceId: focusedWorkspace?.id ?? 1
}