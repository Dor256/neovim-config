return {
    "folke/snacks.nvim",
    opts = {
        picker = {
            -- This ensures search starts from CWD instead of the Git root
            root = false,
            ui_select = true,

            -- Apply these filters to the most common search sources
            sources = {
                files = {
                    ignored = false, -- show/hide files in .gitignore
                    exclude = { "node_modules", ".git", "dist", "build", ".cache" },
                    -- Custom confirm action that opens folder in neo-tree
                    confirm = function(picker, item)
                        picker:close()
                        if item and item.file then
                            -- Open neo-tree at that directory and reveal the file
                            vim.schedule(function()
                                vim.cmd("Neotree reveal " .. vim.fn.fnameescape(item.file))
                            end)
                        end
                    end,
                },
                grep = {
                    exclude = { "node_modules", ".git", "dist", "build", ".cache" },
                },
            },
        },
    },
}

