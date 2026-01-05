return {
    "olimorris/onedarkpro.nvim",
    name = "onedark",
    priority = 1000, -- make sure it loads before other UI plugins
    config = function()
        vim.cmd.colorscheme("onedark")
    end,
}

