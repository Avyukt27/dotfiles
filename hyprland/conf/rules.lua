-- Window rules
local float_class_apps = { "org.pulseaudio.pavucontrol", "blueman-manager", "nm-connection-editor", "qalculate-gtk" }
for _, app in ipairs(float_class_apps) do
	hl.window_rule({
		match = { initial_class = "^(" .. app .. ")$" },
		float = true,
		size = "800 600",
	})
end

local float_title_apps = { "Steam Settings", "Controller Layout" }
for _, app in ipairs(float_title_apps) do
	hl.window_rule({
		match = { title = "^(" .. app .. ")$" },
		float = true,
	})
end

hl.window_rule({
	name = "picture-in-picture",
	match = { initial_title = "^(Picture-in-Picture)$" },
	float = true,
	pin = true,
	move = { "69.5%", "4%" },
})

hl.window_rule({
	name = "floating-window",
	match = { initial_title = "^(?i).*window.*" },
	float = true,
})

hl.window_rule({
	name = "soh-full",
	match = { initial_class = "soh.elf" },
	fullscreen_state = "2",
})

hl.window_rule({
	name = "floating-qemu",
	match = { initial_title = "QEMU" },
	float = true,
})

hl.window_rule({
	name = "ssf2-full",
	match = { class = "steam_app_2521513118" },
	fullscreen_state = "2",
})

-- Layer rules
for _, target in ipairs({ "swaync-control-center", "swaync-notification-window" }) do
	hl.layer_rule({
		match = { namespace = target },
		blur = true,
		ignore_alpha = 0.5,
	})
end

hl.layer_rule({
	name = "waybar_blur",
	match = { namespace = "waybar" },
	blur = false,
})
