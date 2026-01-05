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
                    mode = "buffers", -- Show open files as tabs
                    -- separator_style = "slant", -- Looks very modern
                    always_show_bufferline = true,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = function()
                                return vim.g.cwd_name
                            end,
                            text_align = "left",
                            separator = true,
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
                    separator = { link = 'WinSeparator' },
                    separator_visible = { link = 'WinSeparator' },
                    separator_selected = { link = 'WinSeparator' },
                    offset_separator = { link = 'WinSeparator' },
                },
            })
        end
    }
}

