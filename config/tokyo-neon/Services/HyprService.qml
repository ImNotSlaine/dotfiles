import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

pragma Singleton 

Singleton {
    id: hyprService

    property var ws: Hyprland.workspaces
}