local cmp = require'cmp'
local luasnip = require'luasnip'

local has_words_before = function()
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
        treesitter = "[[Tree]]",
        cmp_tabnine ="[[TN]]",
        tags = "[[Tags]]",
        fuzzy_buffer ="[[Fuzzy]]",
        spell = "[[Spell]]",
        rg = "[[Rg]]",
        tmux = "[Tmux]"

      })
    }),
  },
   mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip and luasnip.expand_or_jumpable() then
          feedkey("<Plug>(luasnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          feedkey("''<Tab>''","") -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),


      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip and luasnip.jumpable(-1) then
          feedkey("<Plug>(luasnip-jump-prev)", "")
        else
          feedkey("<S-Tab>","")
        end
      end, { "i", "s" }),
   },
  sources = {
    { name = 'cmp_tabnine', priority = 7},
    { name = 'nvim_lsp' , priority = 7},
    { name = 'lua_snip' , priority = 8},
    { name = 'treesitter', priority = 6},
    { name = "tags", priority = 5},
    { name = 'fuzzy_buffer',priority = 4},
    { name = 'rg' ,priority = 5, max_item_count = 5, option = { additional_arguments = "--smart-case --max-depth 1" ,debounce = 50,context_before = 3, context_after = 3} },
    { name = 'path', priority = 3 ,trigger_characters = {'/'}, max_item_count = 8},
    { name = 'spell', priority = 3, max_item_count = 5},
    { name = 'tmux', priority = 4, max_item_count = 3 }

  },
  
    sorting = {
        comparators = {
            require('cmp_fuzzy_buffer').compare,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require "cmp-under-comparator".under,
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
cmp.setup.cmdline('/', {
  sources = {
    {name = 'fuzzy_buffer'},
    { name = 'nvim_lsp_document_symbol'},
    { name = "nvim-lsp_signature_help"}
  }
})

cmp.setup.cmdline(':',{
    source ={
    {name = 'cmdline'  },
    {name = 'path'},
  }
})

vim.cmd([[autocmd FileType
\ TelescopePrompt,markdown,asciidoc,gitcommit
\ lua require('cmp').setup.buffer { enabled = false }]])
