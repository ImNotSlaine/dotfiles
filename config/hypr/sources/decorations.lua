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
                border_1 = bg
            },
            border_size_1 = 6
        }
    },

    general = {
        gaps_in = 4,
        gaps_out = 16,

        border_size = 3,

        col = {
            active_border = { colors = { main, main, main_alt }, angle = 45 },
            inactive_border = bg,
        },

        resize_on_border = false,
        allow_tearing = false,
    },

    decoration = {
        rounding = 3,

        shadow = {
            enabled = true,
            range = 15,
            render_power = 5,
            color = "rgba(1d1d1baa)",
        },

        blur = {
            enabled = true,
            size = 2,
            passes = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    }
})