--
-- WORKSPACES RULES
--

hl.workspace_rule({ workspace = 1, monitor = "DP-1" })
hl.workspace_rule({ workspace = 2, monitor = "DP-1" })
hl.workspace_rule({ workspace = 3, monitor = "DVI-D-1", default = true })
hl.workspace_rule({ workspace = 4, monitor = "DVI-D-1" })
hl.workspace_rule({ workspace = "special:background", gaps_out = 32 })

--
-- WINDOW RULES
--

hl.window_rule({
    name = "set_border_special",
    match = { workspace = "special:background" },
    border_color = { colors = { special, special_muted }, angle = 45 } 
})