local ONNVmorph=require("ONNV.morph")
local M={}
function M.run(baseconfig,callback)
  local config=baseconfig.env or {};
  ONNVmorph.morph(config,baseconfig,{"concat","var"});
  for c,v in pairs(config)do
    vim.env[c]=v;
  end
  callback(0,"finished");
end

return M;
