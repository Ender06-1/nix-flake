hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})
hl.monitor({
  output = "eDP-1",
  mode = "2256x1504@60",
  position = "auto",
  scale = 1.333333,
})
hl.monitor({
  output = "desc:AOC 24G2W1G3- 1J4QBHA003151",
  mode = "1920x1080@165.00Hz",
  position = "auto",
  scale = 1,
})
hl.monitor({
  output = "desc:Samsung Electric Company S24D330 0x5A5A5131",
  mode = "1920x1080@60.00Hz",
  position = "auto-right",
  scale = 1,
})

hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("caelestia shell -d")
end)

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11,windows")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 5,
    border_size = 2,

    col = {
      active_border = "rgb(c6b569)",
      inactive_border = "rgb(333231)",
    },

    resize_on_border = false,

    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 20,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
    },

    blur = {
      enabled = false,
    },
  },

  animations = {
    enabled = true,
  },

  input = {
    kb_layout = "us",
    numlock_by_default = true,

    repeat_delay = 200,
    repeat_rate = 40,

    kb_options = "compose:ralt",

    focus_on_close = 1,

    follow_mouse = false,

    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
      scroll_factor = 0.3,
    },
  },

  gestures = {
    workspace_swipe_distance = 700,
    workspace_swipe_cancel_ratio = 0.15,
    workspace_swipe_min_speed_to_force = 5,
    workspace_swipe_direction_lock = true,
    workspace_swipe_direction_lock_threshold = 10,
    workspace_swipe_create_new = true,
  },

  xwayland = {
    force_zero_scaling = true,
  },

  cursor = {
    hotspot_padding = 1,
  },

  misc = {
    vrr = 1,

    animate_manual_resizes = false,
    animate_mouse_windowdragging = false,

    disable_hyprland_logo = true,
    force_default_wallpaper = 0,

    allow_session_lock_restore = true,
    middle_click_paste = false,
    focus_on_activate = true,
    session_lock_xray = true,

    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,

    background_color = "rgb(222017)",
  },
})

hl.config({
  animations = {
    enabled = true,
  },
})

-- Animation curves
hl.curve(
  "specialWorkSwitch",
  { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } }
)
hl.curve(
  "emphasizedAccel",
  { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } }
)
hl.curve(
  "emphasizedDecel",
  { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } }
)
hl.curve("standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })

-- Animation configs
hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 5,
  bezier = "emphasizedDecel",
  style = "slide",
})
hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 4,
  bezier = "emphasizedAccel",
  style = "slide",
})
hl.animation({
  leaf = "fadeLayers",
  enabled = true,
  speed = 5,
  bezier = "standard",
})

hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 5,
  bezier = "emphasizedDecel",
})
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 3,
  bezier = "emphasizedAccel",
})
hl.animation({
  leaf = "windowsMove",
  enabled = true,
  speed = 6,
  bezier = "standard",
})
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 5,
  bezier = "standard",
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 4,
  bezier = "specialWorkSwitch",
  style = "slidefadevert 15%",
})
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "standard" })
hl.animation({
  leaf = "fadeDim",
  enabled = true,
  speed = 6,
  bezier = "standard",
})
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "standard" })

hl.config({
  dwindle = {
    preserve_split = true,
    smart_split = false,
    smart_resizing = true,
  },
})

hl.gesture({
  fingers = 4,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({
  fingers = 3,
  direction = "up",
  action = "special",
  workspace_name = "special",
})

hl.device({
  name = "razer-razer-mamba-tournament-edition",
  accel_profile = "flat",
  sensitivity = -0.25,
})

hl.device({
  name = "razer-razer-basilisk-v3",
  accel_profile = "flat",
})

hl.workspace_rule({
  workspace = "w[tv1]s[false]",
  gaps_out = 20,
})

hl.workspace_rule({
  workspace = "f[1]s[false]",
  gaps_out = 20,
})

----------------
--- BINDINGS ---
----------------

hl.bind("SUPER + SUPER_L", hl.dsp.global("caelestia:launcher"))
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
  ),
  { repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
  ),
  { repeating = true }
)
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1, follow = true }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2, follow = true }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3, follow = true }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4, follow = true }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5, follow = true }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6, follow = true }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7, follow = true }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8, follow = true }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9, follow = true }))

hl.bind(
  "SUPER + SHIFT + 1",
  hl.dsp.window.move({ workspace = 1, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 2",
  hl.dsp.window.move({ workspace = 2, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 3",
  hl.dsp.window.move({ workspace = 3, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 4",
  hl.dsp.window.move({ workspace = 4, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 5",
  hl.dsp.window.move({ workspace = 5, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 6",
  hl.dsp.window.move({ workspace = 6, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 7",
  hl.dsp.window.move({ workspace = 7, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 8",
  hl.dsp.window.move({ workspace = 8, follow = true })
)
hl.bind(
  "SUPER + SHIFT + 9",
  hl.dsp.window.move({ workspace = 9, follow = true })
)

hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float())

hl.bind("SUPER + P", hl.dsp.global("caelestia:lock"))
hl.bind(
  "SUPER + SHIFT + P",
  hl.dsp.exec_cmd("systemctl suspend-then-hibernate"),
  { locked = true }
)

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
  "XF86AudioPlay",
  hl.dsp.global("caelestia:mediaToggle"),
  { locked = true }
)
hl.bind(
  "XF86AudioNext",
  hl.dsp.global("caelestia:mediaNext"),
  { locked = true }
)
hl.bind(
  "XF86AudioPrev",
  hl.dsp.global("caelestia:mediaPrev"),
  { locked = true }
)
hl.bind(
  "XF86AudioStop",
  hl.dsp.global("caelestia:mediaStop"),
  { locked = true }
)

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"))
