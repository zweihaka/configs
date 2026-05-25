vim.pack.add{
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/windwp/nvim-autopairs' },
    { src = 'https://github.com/junegunn/fzf.vim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
}

vim.opt.guicursor = "i-r-cr:block"

require('gitsigns').setup()

require('nvim-autopairs').setup()

require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/custom-treesitter',
}

require('nvim-treesitter').install {'c', 'asm', 'python', 'bash', 'lua', 'yaml', 'dockerfile'}

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'python', 'lua', 'bash', 'asm', 'lua', 'yaml', 'dockerfile'},
  callback = function()
    vim.treesitter.start()

    vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
  end,
})

local servers = { 'clangd', 'pyright', 'bashls', 'dockerls', 'asm_lsp' }
for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
end

vim.lsp.config('yamlls', {
    default_config = {
        filetypes = { 'yaml' },
    }
})
vim.lsp.enable('yamlls')

vim.filetype.add({
    extension = {
        yml = 'yaml',
        yaml = 'yaml',
	asm = 'asm',
	s = 'asm',
	S = 'asm',
    },
    filename = {
        ["docker-compose.yml"] = "yaml",
        ["docker-compose.yaml"] = "yaml",
        [".gitlab-ci.yml"] = "yaml",
    },
})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>vp", ":Lexplore<CR>")
vim.keymap.set("n", "<leader>fp", ":Files<CR>") -- Fuzzy current project directory
vim.keymap.set("n", "<leader>fh", ":Files~<CR>") -- Fuzzy home directory
vim.keymap.set('n', '<leader>gp', ":Rg<CR>") -- ripgrep current project directory
vim.keymap.set('n', '<leader>hp', ":Gitsigns preview_hunk<CR>")

vim.keymap.set('i', '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-n>'
    end
    return '<Tab>'
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-p>'
    end
    return '<S-Tab>'
end, { expr = true })

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.o.termguicolors = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.autocomplete = true
vim.opt.complete:append('o')
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.o.pumheight = 10

vim.api.nvim_set_hl(0, "Comment", { ctermfg = 8, italic = true })

