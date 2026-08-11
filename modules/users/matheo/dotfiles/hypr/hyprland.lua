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
    gaps_in = 5,
    gaps_out = 20,
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

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve(
  "easeOutQuint",
  { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } }
)
hl.curve(
  "easeInOutCubic",
  { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } }
)
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve(
  "almostLinear",
  { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } }
)
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve(
  "easy",
  { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 }
)

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({
  leaf = "border",
  enabled = true,
  speed = 5.39,
  bezier = "easeOutQuint",
})
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4.1,
  spring = "easy",
  style = "popin 87%",
})
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 1.49,
  bezier = "linear",
  style = "popin 87%",
})
hl.animation({
  leaf = "fadeIn",
  enabled = true,
  speed = 1.73,
  bezier = "almostLinear",
})
hl.animation({
  leaf = "fadeOut",
  enabled = true,
  speed = 1.46,
  bezier = "almostLinear",
})
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({
  leaf = "layers",
  enabled = true,
  speed = 3.81,
  bezier = "easeOutQuint",
})
hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "easeOutQuint",
  style = "fade",
})
hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 1.5,
  bezier = "linear",
  style = "fade",
})
hl.animation({
  leaf = "fadeLayersIn",
  enabled = true,
  speed = 1.79,
  bezier = "almostLinear",
})
hl.animation({
  leaf = "fadeLayersOut",
  enabled = true,
  speed = 1.39,
  bezier = "almostLinear",
})
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 1.94,
  bezier = "almostLinear",
  style = "fade",
})
hl.animation({
  leaf = "workspacesIn",
  enabled = true,
  speed = 1.21,
  bezier = "almostLinear",
  style = "fade",
})
hl.animation({
  leaf = "workspacesOut",
  enabled = true,
  speed = 1.94,
  bezier = "almostLinear",
  style = "fade",
})
hl.animation({
  leaf = "zoomFactor",
  enabled = true,
  speed = 7,
  bezier = "quick",
})

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
  )
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
  )
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
