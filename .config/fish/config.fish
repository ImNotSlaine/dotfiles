if status is-interactive
# Commands to run in interactive sessions can go here
	fastfetch
end

########################################################
#      _____ _    _                    __ _      	#
#     |_   _(_)__| |___   __ ___ _ _  / _(_)__ _ 	#
#       | | | / _` / -_) / _/ _ \ ' \|  _| / _` |	#
#       |_| |_\__,_\___| \__\___/_||_|_| |_\__, |	#
#                                          |___/ 	#
#########################################################

set -g tide_left_prompt_items os pwd git
set -g tide_right_prompt_items status cmd_duration

#########
# PWD	#
#########

set -g tide_pwd_bg_color AA00FF
set -g tide_pwd_color_anchors F6F6F5
set -g tide_pwd_color_dirs F6F6F5
set -g tide_pwd_color_truncated_dirs 00B899
set -g tide_pwd_icon_home 󰉌
set -g tide_pwd_icon_unwritable 󱞊
set -g tide_pwd_icon 󰉋

#########
# OS	#
#########

set -g tide_os_icon "Arch Linux $tide_os_icon"
set -g tide_os_color F6F6F5
set -g tide_os_bg_color 00B899

#################
# Status	#
#################

set -g tide_status_bg_color 00B899
set -g tide_status_color F6F6F5
set -g tide_status_bg_color_failure A70E0E
set -g tide_status_color_failure F6F6F5
