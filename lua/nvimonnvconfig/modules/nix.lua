local log=require("nvimonnvconfig.log");
local oeshennixconfig=require("oeshennixonnvconfig.config");
local M={};

local neovimnixhelperpath;
local function nixgetpath(package)
  local systemobj=vim.system({neovimnixhelperpath,"nix","build","--no-link","--print-out-paths",package});
  local outputs=systemobj:wait().stdout --[[@as string]];
  outputs=string.match(outputs,"^(.-)\n");
  return outputs;
end

---@param setupConfig ONNVConfigure.Config
function M.install(setupConfig,callback)
  log.warn("installing nix-helper");
  local installation_path=oeshennixconfig.installation_path;
  log.warn(string.format("building helper-nix with \"%s\"",setupConfig.installation_type));
  if(setupConfig.installation_type=="nix-flake")then
    vim.system({
      "nix","build","--print-out-paths","--no-link"
    },
    {
      cwd=installation_path.."/other/nix-helper",
      detach=true
    },vim.schedule_wrap(function(systemCompleted)
      local outputs=systemCompleted.stdout;
      outputs=string.match(outputs,"^(.-)\n");
      neovimnixhelperpath=outputs.."/bin/nix-helper";
      callback(0,string.format("installed at %s",neovimnixhelperpath))
    end))
  elseif(setupConfig.installation_type=="build-with-nix")then
    vim.system({
      "nix","shell","nixpkgs#gcc","--command",
      "gcc","-O2","-s",installation_path.."/other/nix-helper/neovimnixhelper.c",
      "-o","neovimnixhelper"
    },
    {
      cwd=setupConfig.installation_path.."/bin",
      detach=true
    },vim.schedule_wrap(function()
      neovimnixhelperpath=setupConfig.installation_path.."/bin/neovimnixhelper";
      callback(0,string.format("installed at %s",neovimnixhelperpath))
    end))
  elseif(setupConfig.installation_type=="build-with-system")then
    vim.system({
      "gcc","-O2","-s",installation_path.."/other/nix-helper/neovimnixhelper.c",
      "-o","neovimnixhelper"
    },
    {
      cwd=setupConfig.installation_path.."/bin",
      detach=true
    },vim.schedule_wrap(function()
      neovimnixhelperpath=setupConfig.installation_path.."/bin/neovimnixhelper";
      callback(0,string.format("installed at %s",neovimnixhelperpath))
    end));
  end
end

function M.run(baseconfig,callback)
  local config=baseconfig.nix;
  local selfcr;
  local function run()
    if(config.executables)then
      local totalexecutables = #config.executables;
      for index,executable in ipairs(config.executables)do
        callback(1,string.format("[%d/%d] nix installing %s",index,totalexecutables,executable));
        vim.system({
          neovimnixhelperpath,
          "nix","build","--no-link","--print-out-paths",executable
        },{
          detach=true,
        },vim.schedule_wrap(function(systemCompleted)
          local outputs=systemCompleted.stdout;
          outputs=string.match(outputs,"^(.-)\n");
          vim.env.PATH=string.format("%s/bin:%s",outputs,vim.env.PATH);
          callback(1,string.format("[%d/%d] nix done installing %s",index,totalexecutables,executable));
          coroutine.resume(selfcr);
        end));
        coroutine.yield();
      end
    end
    --[[
    if(config.setvariables)then
      for c,v in pairs(config.setvariables)do
        callback(string.format("nix installing %s",v));
        baseconfig.variables[c]=nixgetpath(v);
      end
    end
    ]]
    callback(0,"finished");
  end
  selfcr=coroutine.create(run);
  coroutine.resume(selfcr);
end

return M;
