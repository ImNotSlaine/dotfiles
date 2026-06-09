--
-- ANIMATIONS
--

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("displayIn",      { type = "bezier", points = { {1, 0},       {0.5, 1}     } })
hl.curve("displayOut",          { type = "bezier", points = { {0, 1},       {1, 0.5}     } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.5, bezier = "displayIn", style = "gnomed" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "displayOut", style = "gnomed" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide bottom" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2, bezier = "almostLinear", style = "slide bottom" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2, bezier = "almostLinear", style = "slide bottom" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "almostLinear", style = "slide top" })