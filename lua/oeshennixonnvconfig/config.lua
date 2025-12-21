local utils=require("nvimonnvconfig.utils")
local M={}

---@class ONNVConfigure.Config
---@field installation_path string
local config={}
config.installation_path={};

local M = utils.newconfig(config) --[[@as ONNVConfigure.Config]]

return M;
