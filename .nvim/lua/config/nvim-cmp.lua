local cmp           = require 'cmp'
local luasnip       = require 'luasnip'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local neogen        = require 'neogen'
neogen.setup({ snippet_engine = "luasnip" })

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local tabnine = require('cmp_tabnine.config')

-- require('tabnine').setup({
--   disable_auto_comment = false,
--   accept_keymap = "<C-TAB>",
--   dismiss_keymap = "<C-e>",
--   debounce_ms = 800,
--   suggestion_color = { gui = "#808080", cterm = 244 },
--   exclude_filetypes = { "TelescopePrompt", "NvimTree", "Vista", "Terminal" },
--   log_file_path = nil, -- absolute path to Tabnine log file
-- })



tabnine:setup({
  max_lines = 50000,
  max_num_results = 100,
  sort = false,
  run_on_every_keystroke = true,
  snippet_placeholder = '..',
  ignored_file_types = {
    TelescopePrompt = true, NvimTree = true, Vista = true, Terminal = true,
  },
  min_percent = 0,
  show_prediction_strength = false,
})

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

local provider = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  luasnip = "[LuaSnip]",
  nvim_lua = "[Lua]",
  latex_symbols = "[Latex]",
  cmp_tabnine = "[Tabnine]",
  treesitter = "[Treesitter]",
  tags = "[Tags]",
  ctags = "[Ctags]",
  fuzzy_buffer = "[FZF]",
  rg = "[RG]",
  path = "[PATH]",
  spell = "[Grammar]",
  tmux = "[Tmux]",
  vimtex = "[Tex]",
  cmp_zotcite = "[Cite]",
  nvim_lsp_document_symbol = "[Symbol]",
  nvim_lsp_signature_help = "[Signature]",
  cmdline = "[CMD]",
}

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local vim_item = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(vim_item.kind, "%s", { trimempty = true })
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
        end
      else
        vim_item.kind = " " .. (strings[1] or cmp_kinds[vim_item.kind]) .. " "
      end
      if entry.source.name == "cmp_tabnine" then
        local detail = (entry.completion_item.labelDetails or {}).detail
        vim_item.kind = ""
        if detail and detail:find('.*%%.*') then
          vim_item.kind = vim_item.kind .. ' ' .. detail
        end

        if (entry.completion_item.data or {}).multiline then
          vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
        end
      end
      if strings[2] == "Variable" or strings[2] == "Text" then
        vim_item.menu = provider[entry.source.name] or ("[" .. (entry.source.name or "") .. "]")
      else
        vim_item.menu = (provider[entry.source.name]) or (
          "  (" .. (strings[2] or entry.source.name or "") .. ")")
      end
      local maxwidth = 80
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
      return vim_item
    end,
  },

  mapping = {
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif neogen.jumpable(1) then
        neogen.jump_prev()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif neogen.jumpable() then
        neogen.jump_next()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }
          neogen.jump_next()
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = false }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),


    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif neogen.jumpable() then
        neogen.jump_next()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif neogen.jumpable(1) then
        neogen.jump_prev()
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = {
    { name = 'cmp_tabnine', priority = 7,  keyword_length = 0, },
    { name = 'nvim_lsp',    priority = 5,  max_item_count = 20, },
    { name = 'luasnip',     priority = 10, },
    { name = 'treesitter',  priority = 5,  max_item_count = 20, },
    { name = "tags",        priority = 5,  max_item_count = 20, },
    {
      name = "ctags", -- default values
      option = {
        executable = "ctags",
        trigger_characters = { "." },
        trigger_characters_ft = {},
      },
      priority = 3,
    },
    { name = 'cmp_zotcite', priority = 6, trigger_characters = { '@' } },
    { name = 'vimtex',      priority = 6 },

    {
      name = 'buffer',
      priority = 5,
      max_item_count = 20,
      option = {
        get_bufnrs = function()
          local bufs = {}
          local function check_size_and_editable(buf)
            local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
            -- if buftype ~= 'nofile' and
            if buftype ~= 'prompt' or buftype == 'help' then
              local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              if byte_size < 10 * 1024 * 1024 then
                return true
              end
            end
          end
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if check_size_and_editable(buf) then
              bufs[buf] = true
            end
          end
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if check_size_and_editable(buf) then
              bufs[buf] = true
            end
          end
          return vim.tbl_keys(bufs)
        end
      }
    },

    -- {
    --   name = 'fuzzy_buffer',
    --   priority = 3,
    --   options = {
    --     get_bufnrs = function()
    --       local bufs = {}
    --       local function check_size_and_editable(buf)
    --         local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
    --         -- if buftype ~= 'nofile' and
    --         if buftype ~= 'prompt' or buftype == 'help' then
    --           local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
    --           if byte_size < 10 * 1024 * 1024 then
    --             return true
    --           end
    --         end
    --       end
    --       for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    --         if check_size_and_editable(buf) then
    --           bufs[buf] = true
    --         end
    --       end
    --       for _, win in ipairs(vim.api.nvim_list_wins()) do
    --         local buf = vim.api.nvim_win_get_buf(win)
    --         if check_size_and_editable(buf) then
    --           bufs[buf] = true
    --         end
    --       end
    --       return vim.tbl_keys(bufs)
    --     end
    --   },
    --   fuzzy_extra_arg = { case_mode = 2 },
    --   min_match_length = 3,
    --   max_matches = 20,
    -- },

    {
      name = 'rg',
      priority = 3,
      option = {
        additional_arguments = "--smart-case --max-depth 1", debounce = 50, context_before = 1, context_after = 0 },
      keyword_length = 3,
      max_item_count = 3,
    },
    { name = 'path',          priority = 3, },
    { name = 'spell',         priority = 2, },
    { name = 'tmux',          priority = 4, },
    -- { name = 'nvim_lsp_document_symbol', priority = 10, max_item_count = 10, },
    -- { name = 'nvim_lsp_signature_help',  priority = 10, max_item_count = 10, },
    -- { name = 'cmdline',                  trigger_characters = { ':', '/', '?', '@', }, priority = 5, keyword_length = 2 },
    { name = "latex_symbols", priority = 10, keyword_length = 2, trigger_characters = { '\\' }, option = { strategy = 0 } },
    { name = "crates",        priority = 10 }
  },
  performance = {
    debonce = 1000,
    throttle = 50,
    fetching_timeout = 200,
    async_budet = 200,
    max_view_entries = 30,
  },

  sorting = {
    comparators = {
      require('cmp_tabnine.compare'),
      require("clangd_extensions.cmp_scores"),
      require('cmp_fuzzy_buffer.compare'),
      require "cmp-under-comparator".under,
      cmp.config.compare.score,
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
    priority_weight = 1,
  },
  completion = {
    -- autocomplete = true,
    keyword_length = 0,
    completeopt = "menu,noselect"
  },
  experimental = {
    ghost_text = true
  },
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?', ':' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline',                  priority = 5 },
    { name = 'path',                     priority = 2 },
    { name = 'buffer',                   priority = 3 },
    { name = 'nvim_lsp_document_symbol', priority = 4 },
    { name = "nvim-lsp_signature_help",  priority = 4 }
  })
})

-- config autopairs


local handlers = require('nvim-autopairs.completion.handlers')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({
  filetypes = {
    -- "*" is a alias to all filetypes
    ["*"] = {
      ["("] = {
        kind = {
          cmp.lsp.CompletionItemKind.Function,
          cmp.lsp.CompletionItemKind.Method,
        },
        handler = handlers["*"]
      }
    },
    lua = {
      ["("] = {
        kind = {
          cmp.lsp.CompletionItemKind.Function,
          cmp.lsp.CompletionItemKind.Method
        },
        ---@param char string
        ---@param item item completion
        ---@param bufnr buffer number
        handler = handlers["*"],
        -- handler = function(char, item, bufnr)
        -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr})
        -- end
      }
    },
    -- Disable for tex
    tex = true
  }
})
)

-- [[ cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket" ]]

vim.cmd([[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
vim.api.nvim_set_hl(0, "CmpItemKindTabNine", { fg = "#6CC644" })
-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })


vim.cmd([[autocmd FileType
\ TelescopePrompt,markdown,asciidoc,gitcommit
\ lua require('cmp').setup.buffer { enabled = true }]])
