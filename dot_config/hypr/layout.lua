hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width             = 1.0,
        focus_fit_method         = 0,
        follow_focus             = true,
        explicit_column_widths   = "0.33333, 0.5, 0.66667",
    },
})

-- Persistent workspaces, pinned to HDMI-A-1 when it's connected.
-- `default = true` on workspace 1 makes it the workspace that appears
-- on HDMI-A-1 at login. Any other monitor gets the leftover workspaces.
for i = 1, 4 do
    hl.workspace_rule({
        workspace  = tostring(i),
        monitor    = "HDMI-A-1",
        persistent = true,
        default    = (i == 1),
    })
end
