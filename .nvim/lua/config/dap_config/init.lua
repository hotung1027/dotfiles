for _, module_name in ipairs({
  'dap_cpp', 
  'dap_flutter',
  'dap_haskell'
}) do
  local ok, err = pcall(require, module_name)
  if not ok then
    local msg = "calling module: "..module_name.." fail: "..err
  end
end

