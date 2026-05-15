vim.pack.add({
  'https://github.com/norcalli/nvim-colorizer.lua.git',
  -- Colorscheme
  "https://github.com/fynnfluegge/monet.nvim",
  'https://github.com/vague-theme/vague.nvim',

  -- Treesitter (MUST be the `main` branch on 0.12; full rewrite)
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "https://github.com/saghen/blink.cmp.git",
  "https://github.com/saghen/blink.lib",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/mason-org/mason.nvim",
  "https://codeberg.org/mfussenegger/nvim-dap.git", 
  "https://github.com/mfussenegger/nvim-dap-python.git",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  "https://github.com/mikavilpas/yazi.nvim.git",
})

require("monet").setup({})
vim.cmd.colorscheme("monet")

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({
  "python",
  "lua", "vim", "vimdoc", "query", "bash", "markdown", "markdown_inline",
})

require("dap-python").setup("uv")

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then return end

    -- language.add() returns (true) on success, (false, err) otherwise.
    if not vim.treesitter.language.add(lang) then return end

    -- Pcall it so a bad parser doesn't spam BufReadPost with errors.
    local ok = pcall(vim.treesitter.start, args.buf, lang)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("telescope").setup({
    extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
  defaults = {
    layout_strategy = "flex",
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top" },
      },
})

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

require("mini.move").setup({
  mappings = {
    left       = "<M-h>",
    right      = "<M-l>",
    down       = "<M-j>",
    up         = "<M-k>",
    line_left  = "<M-h>",
    line_right = "<M-l>",
    line_down  = "<M-j>",
    line_up    = "<M-k>",
  },
})

require("mini.tabline").setup({})

require("mini.surround").setup({})  -- sa/sd/sr: add/delete/replace surround
MiniSurround.config = {
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'ma', -- Add surrounding in Normal and Visual modes
    delete = 'md', -- Delete surrounding
    find = 'mf', -- Find surrounding (to the right)
    find_left = 'mF', -- Find surrounding (to the left)
    highlight = 'mh', -- Highlight surrounding
    replace = 'mr', -- Replace surrounding

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
}

-- require('mini.animate').setup()

require("flash").setup({})

require("nvim-autopairs").setup({
  check_ts = true,  -- use treesitter to avoid pairing inside strings/comments
})

--------------------------------------------------------------------------------
-- Mason (LSP/DAP/linter/formatter installer)
--------------------------------------------------------------------------------
-- Mason only INSTALLS tools. It does not wire up any LSP by itself.
-- On 0.12 configure servers with vim.lsp.config() + vim.lsp.enable(), or add
-- mason-lspconfig if you want auto-enable. Neither is included here.
require("mason").setup({
  ui = {
    icons = {
      package_installed   = "✓",
      package_pending     = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("blink.cmp").setup({
  keymap = { preset = "default" },
  snippets = {preset = "default",},
  -- snippets = {preset = "luasnip",},
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy  = { implementation = "prefer_rust_with_warning" },
  completion = {
    documentation = {
      window = {
        max_width = 60,
      },
    },
  },
})

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})


vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  single_file_support = true,
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
})

vim.lsp.config('ty', {
  cmd = { vim.fn.stdpath('data') .. '/mason/bin/ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ty.toml', '.git' },
  single_file_support = true,
  settings = {
    ty = {
      showSyntaxErrors = false,
      completions = { autoImport = true },
    },
  },
})
vim.lsp.enable('ty')

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_overrides", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end
})

vim.lsp.enable('ruff')   

vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    require("yazi").setup({
      open_for_directories = true,
    })
  end,
})
