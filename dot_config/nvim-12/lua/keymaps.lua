local map = vim.keymap.set

-- General
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<cmd>write<CR>",  { desc = "Write" })
map("n", "<leader>q", "<cmd>quit<CR>",   { desc = "Quit" })
map('n', '<leader>tc', ':tabc<CR>')

-- local mini = require("mini.surround")
-- map("n", "<leader>ma", mini.add , { desc = "Find files" })
-- map("n", "<leader>md", mini.delete, { desc = "Find files" })

-- ty text wrapping

-- ty text wrapping
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover({ max_width = 80 })
end)


-- Telescope
local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'buffers' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>grd', builtin.lsp_definitions, { desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    
vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

-- Flash
local flash = require("flash")
map({ "n", "x", "o" }, "s",  function() flash.jump() end,       { desc = "Flash" })
map({ "n", "x", "o" }, "S",  function() flash.treesitter() end, { desc = "Flash treesitter" })
map({ "o" },           "r",  function() flash.remote() end,     { desc = "Remote flash" })
map({ "o", "x" },      "R",  function() flash.treesitter_search() end, { desc = "TS search" })
map({ "c" },           "<C-s>", function() flash.toggle() end,  { desc = "Toggle flash search" })

-- Mason
map("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason" })

-- Tabline (mini.tabline) — handy buffer navigation
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

vim.keymap.set("n", "<leader>-", function()
  require("yazi").yazi()
end
)
