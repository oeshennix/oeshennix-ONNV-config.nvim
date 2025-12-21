local ONNVmorph=require("ONNV.morph")
local M={}
function M.run(baseconfig)
  local config=baseconfig.env;
  ONNVmorph.morph(config);
  for c,v in pairs(config)do
    vim.env[c]=v;
  end
end

return M;
