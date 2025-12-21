local Config=require("oeshennixonnvconfig.config");
local nvimonnvconfig=require("nvimonnvconfig");
local ONNV=require("ONNV");
local M={};
local function run()
  local config=ONNV.getConfig();
  return config.type=="oeshennix-onnv-config";
end
function M.setup(configuration)
  if(configuration)then
    Config(configuration);
  end
  assert(Config.installation_path,"oeshennixonnvconfig installation path not set");
  nvimonnvconfig.installModules(Config.installmodules);
end

return M;
