#################################################################
#       ____  _   _ _                         __ _       	#
#      / __ \| | (_) |                       / _(_)      	#
#     | |  | | |_ _| | ___    ___ ___  _ __ | |_ _  __ _ 	#
#     | |  | | __| | |/ _ \  / __/ _ \| '_ \|  _| |/ _` |	#
#     | |__| | |_| | |  __/ | (_| (_) | | | | | | | (_| |	#
#      \___\_\\__|_|_|\___|  \___\___/|_| |_|_| |_|\__, |	#
#                                                   __/ |	#
#                                                  |___/ 	#
#################################################################
#################################################
#	 _                     _      		#
#	(_)_ __  _ __  ___ _ _| |_ ___		#
#	| | '  \| '_ \/ _ \ '_|  _(_-<		#
#	|_|_|_|_| .__/\___/_|  \__/__/		#
#		|_|                   		#
#################################################
import os
import subprocess

from libqtile import bar, layout, widget, qtile, hook, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# from qtile_extras import widget

#################################################
#                   _      _    _        	#
#     __ ____ _ _ _(_)__ _| |__| |___ ___	#
#     \ V / _` | '_| / _` | '_ \ / -_|_-<	#
#      \_/\__,_|_| |_\__,_|_.__/_\___/__/	#
#                                        	#
#################################################

mod = "mod4"
terminal = "kitty"

colors = [
	"#1d1d1b",	#background
	"#f6f6f5",	#foreground
	"#aa00ff",	#magenta
	"#00b899",	#cyan
]

#################################
#      _               		#
#     | |_____ _  _ ___		#
#     | / / -_) || (_-<		#
#     |_\_\___|\_, /__/		#
#              |__/    		#
#################################
#########
# WIP	#
#########

keys = [
	#################################
	# Movement between groups	#
	#################################
	Key([mod], "1", lazy.group["Main"].toscreen(), desc="Move focus group to Main"),
	Key([mod], "2", lazy.group["Dev"].toscreen(), desc="Move focus group to Dev"),
	Key([mod], "3", lazy.group["test"].toscreen(), desc="Move focus group to 3"),
	Key([mod, "control"], "1", lazy.window.togroup("Main"), desc="Move focused window to group Main"),
	Key([mod, "control"], "2", lazy.window.togroup("Dev"), desc="Move focused window to group Dev"),
	Key([mod, "control"], "3", lazy.window.togroup("Test"), desc="Move focused window to group 3"),
    
	#########################
	# Focused window	#
	#########################
	Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    	Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    	Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    	Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    	Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
	
	#########################
	# Move focused window	#
	#########################    
	Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    	Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    	Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    	Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

	#################
	# MonadTall	#
	#################
	Key([mod, "control"], "l", lazy.layout.grow()),
	Key([mod, "control"], "h", lazy.layout.shrink()),
	Key([mod, "control"], "n", lazy.layout.reset()),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    # Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    # Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    # Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    # Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    # Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.run_extension(extension.DmenuRun(
	background="#1d1d1b",
	selected_background="#aa00ff",
	foreground="#f6f6f5"
)), desc="Spawn a command using a prompt widget"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


#################
# Groups	#
#################

groups = [
	Group("Main"),
	Group("Dev"),
	Group("test"),
]

####################################################################################################
#      _                    _      
#     | |__ _ _  _ ___ _  _| |_ ___
#     | / _` | || / _ \ || |  _(_-<
#     |_\__,_|\_, \___/\_,_|\__/__/
#             |__/                 
####################################################################################################

layoutsConfigs={
	"margin":10,
	"border_width":5,
	"border_focus":colors[2],
	"border_normal":colors[0]
}

layouts = [
	layout.Max(
		**layoutsConfigs,
	),
    	layout.MonadTall(
		**layoutsConfigs,
		max_ratio=0.8,
		min_ratio=0.5,
		ratio=0.6,
		auto_maximize=True,
	),
    	layout.Zoomy(
		**layoutsConfigs,
		columnwidth=250,
	)
]

#################################################################
#             _    _          _        _              		#
#     __ __ _(_)__| |__ _ ___| |_ ___ | |__  __ _ _ _ 		#
#     \ V  V / / _` / _` / -_)  _(_-< | '_ \/ _` | '_|		#
#      \_/\_/|_\__,_\__, \___|\__/__/ |_.__/\__,_|_|  		#
#                   |___/       				#
#################################################################
#WIP

widget_defaults = dict(
    font="mononoki",
    fontsize=16,
    padding=3,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayoutIcon(
		# 	scale=0.6
		# ),
		widget.GroupBox(
			highlight_method="block",
			this_current_screen_border=colors[2],
		),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
		widget.Wlan(
			interface="wlan0",
			format="net. {essid}",
			disconnected_message="no internet",
		),
                widget.Clock(format="%d/%m/%Y %H:%M"),
                widget.QuickExit(),
            ],
		24,
		margin=10,
		background="#1d1d1b80",
		border_width=[5, 5, 5, 5],  # Draw top and bottom borders
		border_color="#1d1d1b80"  # Borders are magenta
        ),
        # background="#000000",
        # wallpaper=logo,
        # wallpaper_mode="center",
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

idle_inhibitors = []  # type: list

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

autostart = [
	"picom &",
	"feh --bg-fill /home/eugenio/.config/qtile/wallpaper.jpg",
	"eval '$(ssh-agent -T)'",
	"ssh-add .ssh/id_ed25519"
]

for x in autostart:
  	os.system(x)
