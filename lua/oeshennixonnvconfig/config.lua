local utils=require("nvimonnvconfig.utils")
local M={}

---@class ONNVConfigure.Config
---@field installation_path string
---@field installmodules string[]
local config={}
config.installmodules={"nix","LSP"};

local M = utils.newconfig(config) --[[@as ONNVConfigure.Config]]

return M;
