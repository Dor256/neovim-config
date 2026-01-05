return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()

        -- Show definition function
        local _open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = "rounded"
            opts.max_width = 80
            return _open_floating_preview(contents, syntax, opts, ...)
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "eslint",
            },
            automatic_installation = true,
        })

        -- 3. The New Nvim 0.11+ Way
        -- instead of require('lspconfig').server.setup{}, we use vim.lsp.enable()

        -- A. Configure Lua Language Server specifically
        -- We modify the global config table directly before enabling
        -- Lua
        vim.lsp.config.lua_ls = {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        }

        vim.lsp.config.eslint = {
            on_attach = function(_, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, "EslintFixAll", function()
                    vim.lsp.buf.execute_command({
                        command = "eslint.applyAllFixes",
                        arguments = {
                            {
                                uri = vim.uri_from_bufnr(bufnr),
                                version = vim.lsp.util.buf_versions[bufnr]
                            },
                        },
                    })
                end, { desc = "Fix all eslint errors" })
                -- This creates an autocmd to fix files on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end
        }

        -- Haskell
        vim.lsp.config.hls = {
            name = "hls",
            cmd = { "haskell-language-server-wrapper", "--lsp" },
            -- Important: Helps Neovim find the root even if you open a nested file
            root_dir = function(path)
                local root = vim.fs.root(path, { "stack.yaml", "package.yaml", ".git" })
                return root or vim.uv.cwd()
            end,
            filetypes = { "haskell", "lhaskell" },
            settings = {
                haskell = {
                    formattingProvider = "none"
                }
            }
        }
        -- B. Enable the servers
        -- You must explicitly enable the servers you want to run.
        local servers = { "hls", "lua_ls", "ts_ls", "pyright", "eslint" }

        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "haskell", "lhaskell" },
            callback = function()
                local config = vim.lsp.config.hls
                if config then
                    vim.lsp.start(config)
                end
            end,
        })

    end,
}

