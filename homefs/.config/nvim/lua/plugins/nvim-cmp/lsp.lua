local lsp_config = {
    {
        lsp = 'clangd',
        mason = {'clangd'},
    },
    {
        lsp = 'cmake',
        mason = {'cmake-language-server'},
    },
    {
        lsp = 'pyright',
        mason = {'pyright'},
    },
    {
        lsp = 'pylsp',
        mason = {'python-lsp-server'},
    },
    {
        lsp = 'bashls',
        mason = {'bash-language-server', 'shellcheck'},
    },
    {
        lsp = 'awk_ls',
        mason = {'awk-language-server'},
    },
    {
        lsp = 'opencl_ls',
        mason = {'opencl-language-server'},
    },
    {
        lsp = 'dockerls',
        mason = {'dockerfile-language-server'},
    },
    {
        lsp = 'docker_compose_language_service',
        mason = {'docker-compose-language-service'},
    },
    {
        lsp = 'tsserver',
        mason = {'typescript-language-server'},
    },
    {
        lsp = 'jsonls',
        mason = {'json-lsp'},
        lsp_opts = {
            capabilities = (function()
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities.textDocument.completion.completionItem.snippetSupport = true
                return capabilities
            end)()
        },
    },
}

local function foreachi(arr, func)
    if arr then
        local n = #arr
        for i = 1, n do
            local v = arr[i]
            if v then
                func(v, i)
            end
        end
    end
end

-- lsp
local lsp_setup = function(lsp_config)
    local lsp = lsp_config.lsp
    local opts = lsp_config.lsp_opts
    opts = vim.tbl_deep_extend('force', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }, opts or {})
    require('lspconfig')[lsp].setup(opts)
end
foreachi(lsp_config, lsp_setup)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.bo[ev.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'
    end
})

-- mason
local mason = require('mason')
mason.setup({
    install_root_dir = vim.fn.stdpath('config')..'/pack/mason'
})
local mason_setup = function(cfg)
    local pkgs = cfg.mason
    require('mason.api.command').MasonInstall(pkgs)
end
vim.api.nvim_create_user_command("MasonInstallAll", function() foreachi(lsp_config, mason_setup) end, {})

