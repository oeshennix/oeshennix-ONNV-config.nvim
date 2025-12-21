local M={}
local languageconfiguration=require("oeshennix.languageconfiguration");

local function setup(baseconfig,config)
  if(config.clients)then
    for c,v in ipairs(config.clients)do
      local options;
      if(languageconfiguration.setup[v])then
        options=languageconfiguration.setup[v](baseconfig,config[v])
      else
        options=config[v] and config[v].options or nil; 
      end
      if(options)then
        vim.lsp.config(v,options);
      end
      vim.lsp.enable(v,true);
    end;
  end
end


function M.run(baseconfig)
  local config=baseconfig.LSP;
  if(not config.clients)then
    return
  end
  setup(baseconfig,config);
end

return M;
