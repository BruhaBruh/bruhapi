-- BruhAPI v0.0.0
-- Author: BruhaBruh
-- Telegram: https://t.me/bruhabruh4
-- GitHub: https://github.com/bruhabruh/bruhapi

local utils = require("modules.utils")
local logger = require("modules.logger")
local itemView = require("modules.item-view.item-view")

---@class BruhAPI
local bruhapi = {}
bruhapi.logger = logger
bruhapi.prettyLogger = logger:withPretty()
bruhapi.utils = utils
bruhapi.itemView = itemView

return bruhapi
