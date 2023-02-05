-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local api = vim.api
local cmd = vim.cmd

local saveAwesomeWM = api.nvim_create_augroup("SaveAwesomeWM", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.expand("~") .. "/.config/awesome/*",
  command = "silent !echo 'awesome.restart()' | awesome-client",
  group = saveAwesomeWM,
})

local userColors = api.nvim_create_augroup("UserColors", { clear = true })
api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    cmd("highlight Normal ctermbg=NONE guibg=NONE")
    cmd("highlight NormalNC ctermbg=NONE guibg=NONE")
    cmd("highlight NotifyBackground ctermbg=250 guibg=#24273a")
  end,
  group = userColors,
})
