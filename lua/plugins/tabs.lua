return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    mode = "buffer", -- Show open files as tabs
                    separator_style = "slant", -- Looks very modern
                    always_show_bufferline = true,
                    indicator = { style = "none" },
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = function()
                                return vim.g.cwd_name
                            end,
                            text_align = "center",
                            separator = '║',
                            highlight = "Directory",
                            padding = 0,
                        }
                    },
                    custom_filter = function(buf_number)
                        local name = vim.fn.bufname(buf_number)
                        if name == "" then
                            return false -- hide [No Name]
                        end
                        return true
                    end,
                },
                highlights = {
                    offset_separator = {
                        fg = { attribute = "fg", highlight = "WinSeparator" },
                        bg = { attribute = "bg", highlight = "Normal" },
                    },
                },
            })
        end
    }
}

