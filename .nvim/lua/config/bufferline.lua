
require('bufferline').setup {
    options = {
        offsets = {{filetype = "NvimTree", text = " Explorer", padding = 1}},
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        always_show_bufferline = true,
        diagnostic = "nvim_lsp" ,
        diagnostic_indicator = function(count,level,diagnostics_dict,context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,


    }
}
local opt = {noremap = true, silent = true}

