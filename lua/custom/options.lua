vim.opt.clipboard = "unnamedplus"

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.hlsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.shell = "nu"

vim.filetype.add({
    extension = {
        nu = "nu",
        nush = "nu",
    },
    pattern = {
        [".*"] = {
            function(path, bufnr)
                local content = vim.filetype.getlines(bufnr, 1)
                if vim.filetype.matchregex(content, [[^#!/usr/bin/env nu]]) then
                    return "nu"
                end
            end,
            priority = -math.huge,
        },
    },
})
