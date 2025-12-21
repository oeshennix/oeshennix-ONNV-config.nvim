# nvim-ONNV-config
an addon to nvim-ONNV-config to allow nix and LSP configurations

---
## setup

make sure to install [nvim-ONNV-config.nvim](https://github.com/oeshennix/nvim-ONNV-config.nvim) to your following

### [pckr.nvim](https://github.com/lewis6991/pckr.nvim)
```lua
{'oeshennix/oeshennix-ONNV-config.nvim',
  requires={
    'oeshennix/ONNV',
    'oeshennix/nvim-ONNV-config.nvim'
  },
  config=function()
    require('nvimonnvconfig').setup({
      installation_path=require('pckr.config').pack_dir.."/pack/pckr/opt/oeshennix-ONNV-config.nvim"
    });
  end
}
```
### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{'oeshennix/nvim-ONNV-config.nvim',
  dependencies={
    'oeshennix/ONNV',
    'oeshennix/nvim-ONNV-config.nvim'
  },
  config=function()
    require("nvimonnvconfig").setup{installation_path=require('lazy.core.config').options.root.."/oeshennix-ONNV-config.nvim"}
  end
}
```
or
```lua
{'oeshennix/nvim-ONNV-config.nvim',
  dependencies={
    'oeshennix/ONNV',
    'oeshennix/nvim-ONNV-config.nvim'
  },
  opt={installation_path=YOURLAZYROOT.."/oeshennix-ONNV-config.nvim"}
  --if you know where your lazy root installation is
}
```

---
## usage
this adds the nix, LSP and env modules to your nvim-ONNV-config
with nix

in your .ONNV.toml put in
```toml
type="oeshennix-ONNV-config"
using=["env","nix","LSP"]
[env]
"ONNVenv"="this string will be put in the environment variable ONNVenv"

[nix]
executables=["nixpkgs#llvmPackages_20.clang-tools"]

[LSP]
clients=["clangd"]
[LSP.clangd]
cmd=["clangd"]
```
---
this is supposed to be an example of how to add features and modules to nvim-ONNV-config feel free to fork or clone.
Pull requests are welcome.
