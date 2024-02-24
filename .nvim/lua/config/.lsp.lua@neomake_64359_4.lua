-- local installer_present, installer = pcall(require, "nvim-lsp-installer")
local installer_present, installer = pcall(require, "mason")
local server_config_present, server_config = pcall(require, "mason-lspconfig")
local lspconfig_present, _ = pcall(require, "lspconfig")
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
  "clangd", "lua_ls", "efm", "jedi_language_server", "pylsp", "pyright", "julials", "dartls", 'rust_analyzer',
}



local lua_setting = {
  Lua = {
    diagnostics = { globals = { "vim" } },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
      },
      maxPreload = 100000,
      preloadFileSize = 10000
    },
    telemetry = { enable = false }
  }
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
  update_in_insert = false,   -- update diagnostics insert mode
  serverity_sort = true,
}

require 'lspconfig'.julials.setup {}


local capabilities = vim.lsp.protocol.make_client_capabilities()
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

  require 'lsp_signature'.on_attach({
    bind = true,
    hint_prefix = " ",
    handler_opts = {
      border = "rounded",
    }
  }, bufnr)
  lspsaga.setup()
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

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "<F2>", "<cmd>Lspsaga rename<cr>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>Lspsaga code_action<cr>", opts)
  buf_set_keymap("x", "<space>ca", ":<c-u>Lspsaga range_code_action<cr>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  buf_set_keymap("n", "<space>d", "<cmd>lua require('lspsaga.provider).preview_definitions<cr>", opts)
  buf_set_keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  buf_set_keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
  buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gf', "<Cmd>lua require('lspsaga.provider').lsp_finder()<CR>", opts)
  buf_set_keymap('n', '<space>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-q>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    opts)
  buf_set_keymap('n', '<space>wa',
    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts)
  buf_set_keymap('n', 'gt',
    '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap("n", "ec", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "ed", "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[e", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
  buf_set_keymap("n", "]e", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)

  -- buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>",opts)
  -- buf_set_keymap('v','<space>ca',"<cmd>lua  vims.lsp.buf.range_code_action()<CR>",opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e',
  -- '<cmd>lua vim.diagnostic.open_float()<CR>',
  -- opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>',
  -- opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>',
  -- opts)
  buf_set_keymap('n', '<space>q',
    '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  --
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>m", "<cmd>lua vim.lsp.buf.formatting()<CR>",
      opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>m",
      "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false,scope = "cursor"})]]

  vim.cmd([[
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil,1000)
    ]])


  vim.cmd([[
      autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    ]])
  if client.resolved_capabilities.document_highlight then
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

    if server_name == "lua_ls" then
      opts.settings = lua_setting
    elseif server_name == 'hls' then
      opts.settings = haskell_setting
    end

    if #vim.lsp.buf_get_clients() > 0 then
      -- require('lsp-status').status()
    end
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    require("lspconfig")[server_name].setup(opts)
    vim.cmd([[do User LspAttachBuffer]])
  end,
})


local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
