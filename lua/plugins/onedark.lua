return {
    "olimorris/onedarkpro.nvim",
    name = "onedark",
    priority = 1000, -- make sure it loads before other UI plugins
    config = function()
        require("onedarkpro").setup({
            highlights = {
                Directory = { fg = "${purple}" },
                NeoTreeDirectoryName = { fg = "${fg}" },
                NeoTreeRootName = { fg = "${fg}" },
                NeoTreeCursorLine = { bg = "${bg_statusline}" },
                NeoTreeGitUntracked = { fg = "${green}" }
            }
        })
        vim.cmd.colorscheme("onedark")
    end,
}

