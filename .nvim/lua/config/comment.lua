-- ============= NerdTreeCommentary ======================
-- Create default mappings
local NerdTreeCommentaryConfigs = {"NERDCreateDefaultMappings"
    ,"NERDSpaceDelims"
    ,"NERDCompactSexyComs"
    ,"NERDDefaultAlign"
    ,"NERDCommentEmptyLines"
    ,"NERDTrimTrailingWhitespace"
    ,"NERDToggleCheckAllLines"}
for i,config in ipairs(NerdTreeCommentaryConfigs)
    do
        vim.g[config]=1
    end

vim.g.NERDCustomDelimiters = {
        ['c'] = {
            ['left'] = '/**',
            ['right'] = '*/'
        },
    }
