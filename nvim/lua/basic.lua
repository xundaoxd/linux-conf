vim.g.mapleader = ' '

local options = {
    number = true,
    cursorline = true,
    list = true,
    listchars = 'tab:>-,trail:-',
    wrap = false,
    showcmd = true,
    scrolloff = 1000,
    timeoutlen = 300,

    mouse = 'a',
    clipboard = 'unnamedplus',

    shiftwidth = 4,
    tabstop = 4,
    smarttab = true,
    smartindent = true,
    expandtab = true,

    autoread = true,
    autowrite = true
}

for k, v in pairs(options) do
    vim.o[k] = v
end
