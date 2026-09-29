--
-- DECORATIONS
--
hl.config({
    
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
        
        -- screen_shader = "./sources/crt.frag",
        dim_special = 0.6
    },

    animations = {
        enabled = true,
    }
})