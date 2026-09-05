hl.on("hyprland.start", function()
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland DISPLAY XAUTHORITY"
	)
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("systemctl --user restart pipewire wireplumber xdg-desktop-portal xdg-portal-hyprland")

	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("swaync")
	hl.exec_cmd("waybar &")
	hl.exec_cmd("waypaper --restore")
	hl.exec_cmd("brightnessctl set 80%")

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- Custom scripts
	hl.exec_cmd("~/.config/hypr/scripts/battery_notifier")
end)
