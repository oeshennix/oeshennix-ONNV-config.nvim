local Config=require("oeshennixonnvconfig.config");
local nvimonnvconfig=require("nvimonnvconfig");
local ONNV=require("ONNV");
local M={};
local function validate()
  local config=ONNV.getConfig();
  return config.type=="oeshennix-onnv-config";
end
function M.setup(configuration)
  if(configuration)then
    Config(configuration);
  end
  assert(Config.installation_path,"oeshennixonnvconfig installation path not set");
  nvimonnvconfig.installModules(Config.installmodules);
  nvimonnvconfig.addvalidater(validate);
end

return M;
