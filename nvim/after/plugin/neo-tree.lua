-- Watch .git/index for changes to refresh neo-tree git status in real-time
local git_index = vim.fn.getcwd() .. "/.git/index"
if vim.fn.filereadable(git_index) == 0 then
    return
end

local watcher = vim.uv.new_fs_event()
local on_change = vim.schedule_wrap(function()
    if package.loaded["neo-tree"] then
        pcall(function()
            local manager = require("neo-tree.sources.manager")
            local state = manager.get_state("filesystem")
            -- Only refresh if neo-tree has a valid buffer (window is open)
            if state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
                require("neo-tree.sources.filesystem.commands").refresh(state)
            end
        end)
    end
end)

watcher:start(git_index, {}, on_change)

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        watcher:stop()
    end,
})
