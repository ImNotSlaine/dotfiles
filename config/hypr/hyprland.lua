-- HYPRLAND CONFIGURATION FOR TOKYONEON

--
--  SOURCES
--

require("sources._colors")
require("sources.variables")
require("sources.autostart")
require("sources.keybinds")
require("sources.decorations")
require("sources.animations")
require("sources.workspaces")

--
-- MONITORS
--

-- Main PC
hl.monitor({
    output = "DP-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = "1",
})

hl.monitor({
    output = "DVI-D-1",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = "1",
})

--
-- WINDOWRULES (DEFAULT)
--

-- Suppress maximize requests
local suppressMaximizeRule = hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*"
    },
   suppress_event = "maximize",
})

-- Fix drags with XWayland
hl.window_rule({
    name = "fix-wayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- Keeps mouse in focused window if it has a class dotnet (steam games)
hl.window_rule({
    name = "confine-cursor-games",
    match = {
        class = "dotnet",
    },
    confine_pointer = true,
})

--
-- LAYOUT
--

hl.config({
    general = {
        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
    }
})

--
-- INPUT
--

hl.device({
    name = "logitech-g305-1",
    sensitivity = 1,
})