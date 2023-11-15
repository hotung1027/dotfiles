local cmp = require'cmp'
local luasnip = require'luasnip'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
  
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = require("lspkind").cmp_format({with_text = true, menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        latex_symbols = "[Latex]",
        emoji = "[Emoji]",
        treesitter = "[Tree]",
        cmp_tabnine ="[TN]",
        tags = "[Tags]",
        fuzzy_buffer ="[Fuzzy]",
        spell = "[Spell]",
        rg = "[Rg]",
        cmdline = "[cmd]",
      })
    }),
  },
   mapping = {
      -- ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      -- ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = false,
      },
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip and luasnip.expand_or_jumpable() then
         luasnip.expand_or_jump()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<C-l>"] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end),

      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip and luasnip.jumpable(-1) then
         luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
   },
  sources = {
    { name = 'cmp_tabnine', priority = 7},
    { name = 'nvim_lsp' , priority = 7},
    { name = 'luasnip' , priority = 8},
    { name = 'treesitter', priority = 6},
    { name = "tags", priority = 5},
    { name = 'fuzzy_buffer',priority = 4},
    { name = 'rg' ,priority = 5, max_item_count = 5, option = { additional_arguments = "--smart-case --max-depth 1" ,debounce = 50,context_before = 3, context_after = 3} },
    { name = 'path', priority = 3 ,trigger_characters = {'/'}, max_item_count = 8},
    { name = 'spell', priority = 3, max_item_count = 5},
    { name = 'tmux', priority = 4, max_item_count = 3 },
    { name = 'cmdline', priority = 10 },
    { name = 'nvim_lsp_document_symbol', priority = 12},
    { name = 'nvim_lsp_signature_help' , priority = 12 },
  },
  
    sorting = {
        comparators = {
            require('cmp_fuzzy_buffer').compare,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require "cmp-under-comparator".under,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    completion = {
    keyword_length = 1,
    completeopt = "menu,noselect"
    },
    experimental = {
         ghost_text=true
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/','?'}, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {name = 'fuzzy_buffer'},
    { name = 'nvim_lsp_document_symbol'},
    { name = "nvim-lsp_signature_help"}
  })
})

cmp.setup.cmdline(':',{
    source = cmp.config.sources({
    {name = 'cmdline'  },
    {name = 'path'},
  })
})
local handlers = require('nvim-autopairs.completion.handlers')
cmp.event:on('confirm_done',cmp_autopairs.on_confirm_done({
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
        handler = function(char, item, bufnr)
          -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr})
        end
      }
    },
    -- Disable for tex
    tex = false
  }
})
)

--[[ cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket" ]]

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


vim.cmd([[autocmd FileType
\ TelescopePrompt,markdown,asciidoc,gitcommit
\ lua require('cmp').setup.buffer { enabled = true }]])
