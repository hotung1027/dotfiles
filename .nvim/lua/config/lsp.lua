-- local installer_present, installer = pcall(require, "nvim-lsp-installer")
local installer_present, installer = pcall(require, "mason")
-- local server_config_present, server_config = pcall(require, "lspconfig")
local server_config_present, server_config = pcall(require, "mason-lspconfig")

local lspconfig_present, lspconfig = pcall(require, "lspconfig")
if not (lspconfig_present or installer_present or server_config_present) then
  vim.notify("Fail to setup LSP", vim.log.levels.ERROR, { title = 'plugins' })
  return
end
M = {}

local installer_path = os.getenv("HOME") .. "/" .. ".local/share/nvim/mason/packages/"
local codelldb_path = installer_path .. "codelldb/extension/adapter/codelldb"
local liblldb_path = installer_path .. "codelldb/extension/lldb/lib/liblldb.so"

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
  "clangd", "lua_ls", "ruff", "ruff_lsp", "pyright", "jedi_language_server", "julials", 'rust_analyzer',
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
  fileypes = { 'rust', "toml" },
  root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
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
  local msg =string.format("%d diagnostics in buffer %d from %s",
    #diagnostic,
    bufnr,
    name)
  vim.notify(msg,level)
  end,
} ]]




local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    local mode, lhs, rhs, opts = ...
    local attach_opts = { silent = true, buffer = bufnr }

    if opts ~= nil then
      for k, v in pairs(opts) do
        attach_opts[k] = v
      end
    end

    require('utils').map(mode, lhs, rhs, attach_opts)
  end

  local function buf_set_option(...)
    local name, value, _ = ...

    local attach_opts = { buf = bufnr }
    vim.api.nvim_set_option_value(name, value, attach_opts)
  end
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  local filetype = vim.bo.filetype

  local opts = { noremap = true, silent = true }
  if vim.tbl_contains({ 'c', 'cpp', 'h', 'hpp' }, filetype) then
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
  elseif vim.tbl_contains({ 'rust', 'toml' }, filetype) then
    -- vim.lsp.inlay_hint.enable(bufnr, true)
    require('rust-tools').inlay_hints.enable()

    require('rust-tools').hover_actions.hover_actions()
    require('rust-tools').inlay_hints.enable()
  elseif vim.fn.expand('%:t') == 'Cargo.toml' then

  end


  require("lsp_signature").on_attach({

    bind = true,
    handler_opts = {
      border = "rounded",
    },
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

  vim.lsp.handlers["textDocument/hover"] = function(_, _, _)
    vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "single" }
    )
  end

  vim.lsp.handlers["textDocument/signatureHelp"] = function(_, _, _)
    vim.lsp.with(
      vim.lsp.handlers.signature_help,
      {
        border = "single"
      }
    )
  end
  vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
    require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  function show_documentation()
    if vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
      -- require('crates').show_popup()
      require("crates").show_features_popup()
    elseif vim.tbl_contains({ 'rust' }, filetype) then
      require('rust-tools').hover_actions.hover_actions()
    else
      vim.lsp.buf.signature_help()
    end
  end

  function switch_to_source_header()
    if vim.tbl_contains({ 'c', 'cpp', 'h', 'hpp' }, filetype) then
      vim.cmd [[ClangdSwitchSourceHeader]]
    elseif vim.tbl_contains({ 'rust' }, filetype) then
      require 'rust-tools'.open_cargo_toml.open_cargo_toml()
    elseif vim.fn.expand('%:t') == 'Cargo.toml' then
      vim.cmd [[b main.rs]]
    end
  end

  function code_action()
    require("actions-preview").code_actions()
  end

  buf_set_keymap('n', '<leader>gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  buf_set_keymap('n', '<leader>ca', code_action, opts)
  buf_set_keymap('n', '<leader>gk', vim.lsp.buf.hover, opts)
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
  -- popup diagnostic
  -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false,scope = "cursor"})]]

  -- Code Lens
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method("textDocument/codeLens")
  end)

  local group = "lsp_code_lens_refresh"
  local cl_events = { "BufEnter", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })
  local cb = function()
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_is_valid(bufnr) and codelens_supported then
      vim.lsp.codelens.refresh({ bufnr = bufnr })
    end
  end


  if ok and #cl_autocmds > 0 then
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(cl_events, {
      group = group,
      buffer = bufnr,
      callback = cb,
    })
  end


  -- vim.cmd([[
  --     autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
  --   ]])
  if client.server_capabilities.document_highlight then
    vim.cmd [[
        hi lspreferenceread cterm=bold ctermbg=red guibg=darkred
        hi lspreferencetext cterm=bold ctermbg=red guibg=darkred
        hi lspreferencewrite cterm=bold ctermbg=red guibg=darkred
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd cursorhold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd cursormoved <buffer> lua vim.lsp.buf.clear_references()
        augroup end
      ]]
  end
  -- vim.lsp.buf_attach_client(bufnr, client)
end
-- lspinstall + lspconfig stuff



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
  automatic_installation = { exclude = { "rust_analyzer", } },
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
    elseif server_name == "rust_analyzer" then
      opts.settings = rust_setting
    elseif server_name == 'hls' then
      opts.settings = haskell_setting
    elseif server_name == "clangd" then
      opts['on_new_config'] = clangd_setting.on_new_config
    elseif server_name == "pyright" then
      opts["on_init"] =
          function(client)
            client.config.settings.python.pythonpath = get_python_path(client.config.root_dir)
          end
    end


    if #vim.lsp.get_clients() > 0 then
      -- require('lsp-status').status()
    end
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    require("lspconfig")[server_name].setup(opts)
    vim.cmd([[do User LspAttachBuffer]])
  end,

  ["rust_analyzer"] = function()
    require("rust-tools").setup {
      server = {
        on_attach = on_attach,
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
        settings = {
          ["rust_analyzer"] = {

            cargo = {
              features = "all",
            },

            inlayHints = {
              closureCaptureHints = {
                enable = true,
              },
              closureReturnTypeHints = {
                enable = true,
              },
              reborrowHints = {
                enable = true,
              },

            },
            hover = {
              actions = {
                references = {
                  enable = true
                }
              }
            },
            lens = {
              references = {
                method = {
                  enable = true
                },
                trait = {
                  enable = true,
                }

              }
            },
            signatureInfo = {
              documentation = {
                enable = true
              }
            },
            diagnostics = {
              enable = true,
            },

            imports = {
              granularity = {
                group = "module",
              }

            },

            -- filetypes = { "rust", "toml" }

          },
        },

      },
    }
  end,
})


require 'lspconfig'.julials.setup {}
require 'lspconfig'.mojo.setup {} -- Mojo not exist in Mason

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


M.capabilities = capabilities
M.on_attach    = on_attach

return M
