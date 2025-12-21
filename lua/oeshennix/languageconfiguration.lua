local ONNVmorph=require("ONNV.morph");
local languageconfiguration={};
languageconfiguration.setup={};
function languageconfiguration.setup.clangd(baseconfig,settings)
  print("setting up clangd");
  if(not settings)then
    settings={}
  end
  local options={};
  if(settings.cmd)then
    ONNVmorph.morph(settings.cmd,baseconfig,{"var","concat"});
    options.cmd=settings.cmd;
  else
    options.cmd={"clangd"};
  end

  if(settings.useclangdconfig==false)then
    local clangdcachedir=vim.fn.stdpath("cache").."/clangd";
    local compilecommandsfilename=clangdcachedir.."/compile_flags.txt";

    if not (vim.uv or vim.loop).fs_stat(clangdcachedir) then
      local pathcreated=vim.uv.fs_mkdir(clangdcachedir,tonumber("770",8));
      if(not pathcreated)then
        error("failed to create cachedir for clangd");
      end
    end
    local compilecommandsfile=io.open(compilecommandsfilename,"w");
    if(settings.clangflags)then
      ONNVmorph.morph(settings.clangflags,baseconfig,{"var","concat"});
      for c,v in ipairs(settings.clangflags)do
        compilecommandsfile:write(string.format("%s\n",v));
      end
      compilecommandsfile:flush();
    end
    table.insert(options.cmd,string.format("--compile-commands-dir=%s",clangdcachedir));
  end
  return options;
end
function languageconfiguration.setup.ts_ls(baseconfig,settings)
  return {
    cmd={"typescript-language-server", "--stdio"},
    filetypes={ "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
  }
end
function languageconfiguration.setup.lua_ls(baseconfig,settings)
  return settings
end

return languageconfiguration
