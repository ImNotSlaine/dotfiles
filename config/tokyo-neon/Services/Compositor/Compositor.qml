import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Item {
    id: root

    property var workspaces: loader.item ? loader.item.workspaces : []
    property int activeWorkspace: loader.item ? loader.item.activeWorkspace : 1

    Loader {
        id: loader
        sourceComponent: hyprComponent
    }

    Component {
        id: hyprComponent

        Item {
            id: hyprRoot

            property bool isFullscreen: activeTopLevel?.fullscreen || (windowList && windowList.some(w => w.workspace.id === focusedWorkspaceId && w.fullscreen))
            property int activeWorkspace: focusedWorkspaceId
            property var workspaces: Hyprland.workspaces.values

            property int workspaceCount: {
                let max = 10
                for (let i = 0; i < workspaces.lenght; i++) {
                    if (workspaces[i].id > max) max = workspaces[i].id
                }
                return max
            }

            readonly property var toplevels: Hyprland.toplevels
            readonly property var monitors: Hyprland.monitors
            readonly property var activeTopLevel: Hyprland.focusedWindow
            readonly property var focusedWorkspace: Hyprland.focusedWorkspace
            readonly property var focusedMonitor: Hyprland.focusedMonitor
            readonly property int focusedWorkspaceId: focusedWorkspace?.id ?? 1

            property var workspacesInfo: []
            property var workspaceById: ({})
            property var workspacesIds: []

            function updateAll() {
                getWorkspaces.running = true
            }

            Process {
            id: getWorkspaces
            command: ["hyprctl", "workspaces", "-j"]
            stdout: StdioCollector {
                onStreamFinished: {
                    try {
                        hyprRoot.workspacesInfo = JSON.parse(this.text)
                        let map = {}
                        for (let ws of hyprRoot.workspacesInfo) map[ws.id] = ws
                        hyprRoot.workspaceById = map
                        hyprRoot.workspacesIds = hyprRoot.workspacesInfo.map(ws => ws.id)
                    } catch (e) {
                        console.error("Failed to parse workspaces:", e)
                    }
                }
            }
            }

            Component.onCompleted: {
                updateAll()
            }
        }
    }
}