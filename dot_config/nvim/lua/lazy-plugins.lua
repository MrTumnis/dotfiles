-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'junegunn/fzf.vim',
  'preservim/nerdtree',
  'rust-lang/rust.vim',
  'tpope/vim-commentary',
  -- 'jeetsukumaran/vim-pythonsense',
  'jiangmiao/auto-pairs',
  'Vimjas/vim-python-pep8-indent',
  'neomake/neomake',
  --  'numirias/semshi',
  --  'williamboman/mason-lspconfig.nvim',
  'kyazdani42/nvim-web-devicons',
  'kyazdani42/nvim-tree.lua',
  --  "lunarvim/onedarker.nvim",
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'rafamadriz/friendly-snippets',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  { 'neovim/nvim-lspconfig', opts = {} },
  'numToStr/Comment.nvim',
  -- 'akinsho/bufferline.nvim',
  -- 'moll/vim-bbye',
  -- 'lervag/vimtex',
  -- 'goolord/alpha-nvim',
  'antoinemadec/FixCursorHold.nvim', -- This is needed to fix lsp doc highlight
  -- 'lukas-reineke/indent-blankline.nvim',
  -- 'nvim-lualine/lualine.nvim',
  -- 'deoplete-plugins/deoplete-jedi',
  'ziglang/zig.vim',
  'norcalli/nvim-colorizer.lua',
  -- 'chrisbra/Colorizer',
  -- 'metalelf0/base16-black-metal-scheme',
  -- 'ervandew/supertab',
  -- 'lotabout/skim', "{ 'dir': '~/.skim', 'do': './install' }"
  -- { 'davidhalter/jedi-vim', enable = vim.g.auto_completions_enabled, vim.g.auto_initialization },
  'mg979/vim-visual-multi',
  'jezda1337/nvim-html-css',
  'nvim-lua/plenary.nvim',
  'leafOfTree/vim-svelte-plugin',
  -- {
  --   'webhooked/kanso.nvim',
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   'uloco/bluloco.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { 'rktjmp/lush.nvim' },
  --   config = function()
  --     vim.opt.termguicolors = true
  --     vim.cmd 'colorscheme bluloco'
  --     -- your optional config goes here, see below.
  --   end,
  -- },
  -- {
  --   'ribru17/bamboo.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('bamboo').setup {
  --       -- optional configuration here
  --     }
  --     require('bamboo').load()
  --   end,
  -- },
  --
  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  'williamboman/mason.nvim',
  opts = {
    ensure_installed = {
      'pyright',
      'html-lsp',
      'json-lsp',
    },
  },

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/markdown',

  -- require 'kickstart/plugins/solarized',

  require 'kickstart/plugins/neoclip',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/blink-cmp',

  require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/yazi',

  require 'kickstart/plugins/treesitter',

  require 'kickstart/plugins/flash',

  require 'kickstart/plugins/nvim-ts-autotag',

  -- require 'kickstart/plugins/obsidian',

  -- require 'kickstart/plugins/*',

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
