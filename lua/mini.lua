-- 最小配置

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- todo: 这里优化目录
  -- Status Line
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("ui.lualine").config()
    end,
    event = "VimEnter",
    dependencies = {
      {
        "edte/lualine-ext",
      },
      -- {
      --   "christopher-francisco/tmux-status.nvim",
      --   opts = {
      --     window = {
      --       separator = "  ",
      --       icon_zoom = "",
      --       icon_mark = "",
      --       icon_bell = "",
      --       icon_mute = "",
      --       icon_activity = "",
      --       text = "name",
      --     },
      --   },
      -- },
    },
  },
})
