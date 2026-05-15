hl.window_rule({
    name      = "brave-to-ws4",
    match     = { class = "brave-browser" },
    workspace = "4",
})

hl.window_rule({
    name  = "clipse-float",
    match = { class = "clipse" },
    float = true,
    size  = "922 652",
})

hl.window_rule({
    name  = "all",
    match = { class = "wants to open" },
    float = true,
    size  = "622 652",
})

hl.window_rule({
    name     = "bitwarden-maximize",
    match    = { title = "Bitwarden" },
    maximize = false,
})

-- hl.window_rule({
--     name           = "suppress-maximize-events",
--     match          = { class = ".*" },
--     suppress_event = "maximize",
-- })
