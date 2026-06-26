--
-- DECORATIONS
--

-- Borders++
hl.config({
    plugin = {
        borders_plus_plus = {
            add_borders = 1,
            natural_rounding = true,
            col = {
                border_1 = focus_off
            },
            border_size_1 = 4
        }
    },
    
-- Borders
    general = {
        gaps_in = 4,
        gaps_out = 16,

        border_size = 4,

        col = {
            active_border = { colors = { focus, focus, focus_muted }, angle = 45 },
            inactive_border = focus_off,
        },

        resize_on_border = false,
        allow_tearing = false,
    },

-- Decorations
    decoration = {
        rounding = 8,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 1,
            color = "#00000055",
            offset = {4, 4},
        },

        blur = {
            enabled = true,
            size = 4,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    }
})