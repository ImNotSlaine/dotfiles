-- Autostart programs

hl.on("hyprland.start", function()
    hl.exec_cmd("eval ssh-agent $SHELL")
    hl.exec_cmd("ssh-add .ssh/id_ed25519")
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("qs -p $HOME/.config/tokyo-neon")
end)