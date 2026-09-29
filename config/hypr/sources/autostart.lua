-- Autostart programs

hl.on("hyprland.start", function()
    hl.exec_cmd("eval ssh-agent $SHELL")
end)