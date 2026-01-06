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

            -- Custom action to open file and reveal in Neo-tree
            actions = {
                open_and_reveal = function(picker)
                    local items = picker:selected()
                    if #items == 0 then
                        items = { picker:current() }
                    end

                    picker:close()
                    for _, item in ipairs(items) do
                        if item and item.file then
                            vim.cmd("edit " .. vim.fn.fnameescape(item.file))
                            vim.schedule(function()
                                vim.cmd("Neotree reveal " .. vim.fn.fnameescape(item.file))
                                -- Focus back on the file
                                vim.cmd.wincmd("p")
                            end)
                        end
                    end
                end,
            },

            -- Map Enter key to our custom action
            win = {
                input = {
                    keys = {
                        ["<cr>"] = { "open_and_reveal", mode = { "i", "n" } },
                    },
                },
            },
        },
    },
}

