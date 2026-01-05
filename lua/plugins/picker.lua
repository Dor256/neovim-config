return {
    "folke/snacks.nvim",
    opts = {
        picker = {
            -- This ensures search starts from CWD instead of the Git root
            root = false,

            -- Apply these filters to the most common search sources
            sources = {
                files = {
                    ignored = false, -- show/hide files in .gitignore
                    exclude = { "node_modules", ".git", "dist", "build", ".cache" },
                },
                grep = {
                    exclude = { "node_modules", ".git", "dist", "build", ".cache" },
                },
            },
        },
    },
}

