local log=require("nvimonnvconfig.log");
local oeshennixconfig=require("oeshennixonnvconfig.config");
local M={}

local neovimnixhelperpath;
local function nixgetpath(package)
  local systemobj=vim.system({neovimnixhelperpath,"nix","build","--no-link","--print-out-paths",package});
  local outputs=systemobj:wait().stdout;
  outputs=string.match(outputs,"^(.-)\n");
  return outputs;
end

---@param setupConfig ONNVConfigure.Config
function M.install(setupConfig)
  log.warn("installing nix-helper");
  local installation_path=oeshennixconfig.installation_path;
  log.warn(string.format("building helper-nix with \"%s\"",setupConfig.installation_type));
  if(setupConfig.installation_type=="nix-flake")then
    local system=vim.system({
      "nix","build","--print-out-paths","--no-link"
    },
    {
      cwd=installation_path.."/other/nix-helper"
    })
    local outputs=systemobj:wait().stdout;
    outputs=string.match(outputs,"^(.-)\n");
    neovimnixhelperpath=outputs.."/bin";
  elseif(setupConfig.installation_type=="build-with-nix")then
    vim.system({
      "nix","shell","nixpkgs#gcc","--command",
      "gcc","-O2","-s",installation_path.."/other/nix-helper/neovimnixhelper.c",
      "-o","neovimnixhelper"
    },
    {
      cwd=setupConfig.installation_path.."/bin"
    })
    neovimnixhelperpath=setupConfig.installation_path.."/bin/neovimnixhelper";
  end
end

function M.run(baseconfig)
  local config=baseconfig.nix;
  if(config.executables)then
    for c,v in ipairs(config.executables)do
      vim.env.PATH=string.format("%s/bin:%s",nixgetpath(v),vim.env.PATH);
    end
  end
  if(config.setvariables)then
    for c,v in pairs(config.setvariables)do
      baseconfig.variables[c]=nixgetpath(v);
    end
  end
end

return M;
