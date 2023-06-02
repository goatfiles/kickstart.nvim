local M = {}  
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
})

vim.cmd.colorscheme "dracula"

vim.cmd([[
  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  set listchars=tab:>\·,trail:\ ,extends:>,precedes:<,nbsp:+

  " Show problematic characters.
  set list
]])

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    pattern = "*",
    callback = function ()
        if vim.bo.filetype == "" or
           vim.bo.filetype == "aerial" or
           vim.bo.filetype == "help"
        then
            return nil
        end

        local color = "darkred"

        vim.cmd {
            cmd = "highlight",
            args = {
                "ExtraWhitespace" ,
                string.format("ctermbg=%s", color),
                string.format("guibg=%s", color)
            },
            bang = false,
        }
        vim.cmd {
            cmd = "match",
            args = {"ExtraWhitespace" , "/\\s\\+$/"},
            bang = false,
        }
    end
})

M.nvim_create_augroups{
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"}
    }
}
