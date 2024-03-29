-- local installer_present, installer = pcall(require, "nvim-lsp-installer")
local installer_present, installer = pcall(require, "mason")
-- local server_config_present, server_config = pcall(require, "lspconfig")
local server_config_present, server_config = pcall(require, "mason-lspconfig")

local lspconfig_present, lspconfig = pcall(require, "lspconfig")
local lspsaga = require("lspsaga")
if not (lspconfig_present or installer_present or server_config_present) then
  vim.notify("Fail to setup LSP", vim.log.levels.ERROR, { title = 'plugins' })
  return
end

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}
local servers = {
  "clangd", "lua_ls", "pyright", "julials", 'rust_analyzer',
}

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, 'Pipfile'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
    return path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

local lua_setting = {
  Lua = {
    diagnostics = { globals = { "vim" } },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
      },
      maxPreload = 1000,
      preloadFileSize = 100
    },
    telemetry = { enable = false }
  }
}

local mojo_setting = {

  cmd = { "mojo-lsp-server" }
}
local clangd_setting = {
  on_new_config = function(new_config, new_cwd)
    local status, cmake = pcall(require, "cmake-tools")
    if status then
      cmake.clangd_on_new_config(new_config)
    end
  end,
}
local rust_setting = {
  ['rust_analyzer'] = {
    cargo = {
      features = "all",
    },
    inlayHints = {
      closureCaptureHints = {
        enable = true,
      },
    },

    diagnostics = {
      enable = true,
    },

  },
  -- fileypes = { 'rust', "toml" },
  -- root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
}

local haskell_setting = {
  haskell = {
    hlintOn = true,
    formattingProvider = 'brittany',
  }
}

local lsp_publish_diagnostics_options = {
  virtual_text = {
    prefix = "",
    source = "if_many",
    spacing = 0
  },
  signs = true,
  underline = true,
  float = true,
  update_in_insert = true, -- update diagnostics insert mode
  serverity_sort = true,
}

require 'lspconfig'.julials.setup {}
require 'lspconfig'.mojo.setup {}

local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

capabilities.textDocument.completion.completionItem.documentationFormat = {
  "markdown",
  "plaintext"
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits" }
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 }
}

local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handlers = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handlers
end

function code_action_listener()
  local context = { diagnostics = vim.diagnostic.get() }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, _, result)
    -- do something with result - e.g. check if empty and show some indication such as a sign
  end)
end

local handlers = {

  ["textDocument/hover"] =
      vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "single" }
      ),

  ["textDocument/signatureHelp"] =
      vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
          border = "single"
        }
      ),
  ["textDocument/references"] =
      vim.lsp.with(
        vim.lsp.handlers["textDocument/references"],
        {
          loclist = true,
        }),
  ["textDocument/publishDiagnostics"] =
      vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        lsp_publish_diagnostics_options
      ),

  ["textDocument/definition"] = goto_definition('split'),

}


vim.diagnostic.config(lsp_publish_diagnostics_options)
--[[ vim.diagnostic.handlers["info/notify"] = {
  show = function(namespace,bufnr,diagnostic,opts)
  local level = opts["info/notify"].log_level
  local name = vim.diagnostic.get_namespace(namespace).name
  local msg = string.format("%d diagnostics in buffer %d from %s",
    #diagnostic,
    bufnr,
    name)
  vim.notify(msg,level)
  end,
} ]]




local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
  require("clangd_extensions.inlay_hints").setup_autocmd()
  require("clangd_extensions.inlay_hints").set_inlay_hints()
  require 'lsp_signature'.on_attach({
    bind = true,
    hint_prefix = " ",
    handler_opts = {
      border = "rounded",
    }
  }, bufnr)
  lspsaga.setup()

  require("lsp_signature").on_attach({
    hint_prefix = "👍 ",
    floating_window_off_x = 5,                         -- adjust float windows x position.
    floating_window_off_y = function()                 -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
      local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
      local pumheight = vim.o.pumheight
      local winline = vim.fn.winline()                 -- line number in the window
      local winheight = vim.fn.winheight(0)

      -- window top
      if winline - 1 < pumheight then
        return pumheight
      end

      -- window bottom
      if winheight - winline < pumheight then
        return -pumheight
      end
      return 0
    end,
  }, bufnr)
  -- vim.api.nvim_command('au User LspDiagnosticsChanged lua require("lsp-status/redraw").redraw()')

  vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
    require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
  end

  vim.lsp.handlers['textDocument/references'] = function(_, _, result)
    require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
  end

  vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
    require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
    require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
    require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
    require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
    require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
  end

  vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
    require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
  end
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      underline = true,
      virtual_text = {
        spacing = 5,
        severity_limit = 'Warning',
      },
      update_in_insert = true,
    }
  )
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap = true, silent = true }
  function show_documentation()
    local filetype = vim.bo.filetype
    if vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
      require('crates').show_popup()
    else
      vim.lsp.buf.signature_help()
    end
  end

  function siwtch_to_source_header()
    local filetype = vim.bo.filetype

    if vim.tbl_contains({ 'c', 'cpp', 'h', 'hpp' }, filetype) then
      vim.cmd [[ClangdSwitchSourceHeader]]
    elseif vim.tbl_contains({ 'rust' }, filetype) then
      vim.cmd [[RustOpenCargo]]
    elseif vim.fn.expand('%:t') == 'Cargo.toml' then
      vim.cmd [[b main.rs]]
    end
  end

  buf_set_keymap("n", "<F2>", "<cmd>Lspsaga rename<cr>", opts)
  -- buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
  buf_set_keymap('n', '<leader>gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>gf', "<Cmd>lua require('lspsaga.provider').lsp_finder()<CR>", opts)
  buf_set_keymap('n', 'K', "<cmd>lua show_documentation()<CR>", opts)
  buf_set_keymap("n", "<leader>gh", "<cmd>lua siwtch_to_source_header()<CR>", opts)

  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)

  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts)
  buf_set_keymap('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  --
  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap("n", "<leader>gm", "<cmd>lua vim.lsp.buf.format()<CR>",
      opts)
    vim.cmd([[
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format({aysnc = false, timeout_ms = 1000})
    ]])
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("x", "<leader>gm",
      "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  end
  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false,scope = "cursor"})]]



  vim.cmd([[
      autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    ]])
  if client.server_capabilities.document_highlight then
    vim.cmd [[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkRed
        hi LspReferenceText cterm=bold ctermbg=red guibg=DarkRed
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=DarkRed
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]]
  end
end
-- lspInstall + lspconfig stuff



installer.setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

server_config.setup({
  ensure_installed = servers,
})


server_config.setup_handlers({
  function(server_name)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = vim.loop.cwd,
      handlers = handlers,
    }
    local run_custom_extern_settings = false
    if server_name == "lua_ls" then
      opts.settings = lua_setting
    elseif server_name == 'hls' then
      opts.settings = haskell_setting
    elseif server_name == "rust_analyzer" then
      opts.settings = rust_setting
      local dbg_path = require('config.dap_config.dap').installer_path
      require("rust-tools").setup({
        server = opts,
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(dbg_path .. 'codelldb', ''),
        },
      })
      run_custom_extern_settings = true
    elseif server_name == "clangd" then
      opts['on_new_config'] = clangd_setting.on_new_config
      require('cmake-tools').setup({})
    elseif server_name == "pyright" then
      opts["on_init"] =
          function(client)
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
          end
    end


    if #vim.lsp.buf_get_clients() > 0 then
      -- require('lsp-status').status()
    end
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    if not run_custom_extern_settings then
      require("lspconfig")[server_name].setup(opts)
    end
    vim.cmd([[do User LspAttachBuffer]])
  end,
})


local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
