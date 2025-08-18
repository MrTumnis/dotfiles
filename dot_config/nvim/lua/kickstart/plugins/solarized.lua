return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  ---@type solarized.config
  opts = {
    on_colors = function(colors, color)
      local lighten = color.tint
      local darken = color.darken

      return {
        fg = lighten(colors.base00, 2),
        bg = darken(colors.base04, 30),
      }
    end,
    highlights = function(colors)
      return {
        Normal = { fg = colors.fg, bg = colors.bg },
      }
    end,
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'
  end,
}
