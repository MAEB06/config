require("config.lazy")
require("set")
require("config.remap.remap")
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        local path = vim.fn.expand("%:p:h")
        -- Skip oil:// buffers and ensure path is a valid directory
        if vim.fn.isdirectory(path) == 1 and not vim.startswith(path, "oil://") then
            vim.cmd("cd " .. path)
        end
    end,
})

vim.diagnostic.config({ virtual_text = true })
