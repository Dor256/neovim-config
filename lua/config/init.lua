vim.g.mapleader = " "
local first_arg = vim.fn.argv(0)
if first_arg ~= "" then
    -- Resolve to absolute path and strip trailing slash
    local abs_path = vim.fn.fnamemodify(first_arg, ":p"):gsub("/$", "")
    -- If the argument is a directory, change to it
    if vim.fn.isdirectory(abs_path) == 1 then
        vim.cmd("cd " .. vim.fn.fnameescape(abs_path))
    end
    vim.g.cwd_name = vim.fn.fnamemodify(abs_path, ":t")
else
    vim.g.cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end
require("config.lazy")
require("config.settings")
require("config.keymaps")

vim.diagnostic.config({
    -- Ensure the most severe diagnostic is the one highlighted
    severity_sort = true,

    -- Fine-tune how they appear
    virtual_text = {
        -- Only show virtual text for the highest severity on a line
        severity = { min = vim.diagnostic.severity.WARN },
        spacing = 4,
    },
    underline = true,
})

-- How long to wait (in milliseconds) before the window pops up
-- 500ms is a good balance between "snappy" and "not annoying"
vim.opt.updatetime = 500

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "CursorMoved", "CursorMovedI", "BufLeave" },
            source = 'always',
            prefix = ' ',
            header = "",
            scope = 'cursor',
            border = "rounded",
        }
        vim.diagnostic.open_float(nil, opts)
    end
})

-- Autosave
-- Simple autosave on leaving insert mode or changing text
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and vim.fn.bufname() ~= "" then
            vim.cmd("silent! update")
        end
    end,
})

