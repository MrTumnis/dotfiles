local M = {}

function M.chord(...)
    return table.concat({...}, " + ")
end

M.mod = "SUPER"
M.sft = "SHIFT"
M.ctl = "CTRL"
M.alt = "ALT"

return M
