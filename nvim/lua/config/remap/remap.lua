vim.g.mapleader = " "
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    local query = vim.fn.input("Grep > ")
    if query ~= "" then
        local cwd = vim.fn.expand("%:p:h")
        builtin.grep_string({
            search = query,
            cwd = cwd,
            additional_args = { "--ignore-case", "--hidden", "--no-ignore" },
        })
    else
        print("Error: Empty search query")
    end
end)

vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)

vim.keymap.set("v", "j", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "k", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<n>", "<nzzzv")
vim.keymap.set("n", "<N>", "<Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open LSP diagnostic" })

vim.keymap.set("n", "<leader>r", function()
    vim.cmd("write")

    local ft = vim.bo.filetype
    local filename = vim.fn.expand("%")
    local basename = vim.fn.expand("%:r")

    if ft == "cpp" or ft == "c" then
        vim.cmd("botright split | resize 10 | terminal g++ " .. filename .. " -o " .. basename .. " && ./" .. basename)
    elseif ft == "python" then
        vim.cmd("botright split | resize 10 | terminal python3 " .. filename)
    elseif ft == "java" then
        vim.cmd("botright split | resize 10 | terminal javac " .. filename .. " && java " .. basename)
    elseif ft == "lua" then
        vim.cmd("botright split | resize 10 | terminal lua " .. filename)
    elseif ft == "csharp" then
        vim.cmd("botright split | resize 10 | terminal mcs " .. filename .. " && mono " .. basename .. ".exe")
    else
        print("No run command configured for filetype: " .. ft)
    end
end, { desc = "Compile and run current file based on filetype" })
