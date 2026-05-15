hl.config({
    input = {
        kb_layout    = "us",
        kb_options   = "caps:swapescape",
        repeat_rate  = 30,
        repeat_delay = 200,
        follow_mouse  = 1,
        mouse_refocus = false,
        sensitivity   = 0,
        touchpad = {
            tap_to_click   = true,
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Per-device overrides go here:
-- hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
