local Snacks = require("snacks")
-- Diagnostic Keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>o", function()
    -- If we are currently in the Neo-tree window...
    if vim.bo.filetype == "neo-tree" then
        -- ...jump back to the previous window (the code)
        vim.cmd.wincmd("p")
    else
        -- ...otherwise, focus the Neo-tree window
        vim.cmd("Neotree focus")
    end
end, { desc = "Toggle focus between Neo-tree and Editor" })

-- Tabs Keymaps
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>')

-- Bufremove
vim.keymap.set("n", "<leader>w", function()
    require("mini.bufremove").delete(0, true)
end, { desc = "Close current buffer and move to next" })

-- Move text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace highlited text everywhere
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Format file
vim.keymap.set("n", "<leader>r", function()
    local view = vim.fn.winsaveview()
    vim.cmd("normal! ggVG=")
    vim.fn.winrestview(view)
end, { desc = "Indent file without moving cursor" })

-- LSP
-- Hover documentation
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "LSP help/documentation" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP jump to definition" })
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "LSP jump to declaration" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP jump to implementation" })
vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "LSP jump to type definition" })
vim.keymap.set("n", "<leader>gr", Snacks.picker.lsp_references, { desc = "LSP jump to references" })

-- Toggle comment on the current line
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
-- Toggle comment on selected lines
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment selection" })

-- Picker search
-- Toggle/Resume the last picker you had open
vim.keymap.set("n", "<leader>f", function() Snacks.picker.grep() end, { desc = "Resume Last Search" })

-- Terminal
-- Allow <Esc> to enter normal mode in terminal for browsing output
vim.keymap.set('t', '<S-Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode to normal mode" })

