return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
      per_filetype = {
        html = {
          enable_close = true, -- set this to true to enable auto-close in HTML
        }
      }
    })
  end,
}

