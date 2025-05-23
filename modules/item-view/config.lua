local viewConfig = require("modules.item-view.view-config")

---@class BruhAPI.ItemView.Config
---@field hideOnSelectedMainHand boolean
---@field hideOnSelectedOffHand boolean
---@field block BruhAPI.ItemView.ViewConfig
---@field item BruhAPI.ItemView.ViewConfig
---@field tool BruhAPI.ItemView.ViewConfig
---@field food BruhAPI.ItemView.ViewConfig
---@field armor BruhAPI.ItemView.ViewConfig
---@field containsItem table<string, BruhAPI.ItemView.ViewConfig>
---@field exactItem table<string, BruhAPI.ItemView.ViewConfig>
---@field custom (fun(ItemStack, ItemTask): boolean)[]
local itemViewConfig = {}
itemViewConfig.__index = itemViewConfig

---@param cfg BruhAPI.ItemView.Config
---@param key string
---@param value any
---@return BruhAPI.ItemView.Config
local function with(cfg, key, value)
  local instance = setmetatable({}, getmetatable(cfg))

  for k, v in pairs(cfg) do
    instance[k] = v
  end

  instance[key] = value

  return instance
end

---@return BruhAPI.ItemView.Config
function itemViewConfig:new()
  local instance = setmetatable({}, itemViewConfig)
  instance.hideOnSelectedMainHand = false
  instance.hideOnSelectedOffHand = false
  instance.block = viewConfig:new()
  instance.item = viewConfig:new()
  instance.tool = viewConfig:new()
  instance.food = viewConfig:new()
  instance.armor = viewConfig:new()
  instance.containsItem = {}
  instance.exactItem = {}
  instance.custom = {}
  return instance
end

---@return BruhAPI.ItemView.Config
function itemViewConfig:default()
  local config = itemViewConfig:new()

  local blockConfig = viewConfig:new()
      :withScale(0.38)
      :withRot(-25, 45, -17)
      :withPos(0, 0.4, -2.3)
  local itemConfig = viewConfig:new()
      :withScale(0.5)
      :withRot(-90, 0, 180)
      :withPos(0, 1, -2.75)
  local toolConfig = viewConfig:new()
      :withScale(0.85)
      :withRot(-90, -45, -90)
      :withPos(0, 1.5, -4)
  local armorConfig = viewConfig:new()
  local bedConfig = viewConfig:new()
      :withScale(0.23)
      :withRot(-50, -25, 15)
      :withPos(1, 0.4, -4.2)
  local bannerConfig = viewConfig:new()
      :withScale(0.4)
      :withRot(-90, 0, 90)
      :withPos(0, 0, -2)
  local spyglassConfig = viewConfig:new()
      :withScale(1)
      :withRot(-90, 0, -90)
      :withPos(0, 0, 2)
  local bowConfig = viewConfig:new()
      :withScale(0.9)
      :withRot(-90, -45, -90)
      :withPos(-1, 2.2, 2)
  local crossbowConfig = viewConfig:new()
      :withScale(0.95)
      :withRot(0, 0, -125)
      :withPos(1, -4, 0)
  local shieldConfig = viewConfig:new()
      :withScale(1)
      :withRot(-90, 0, -270)
      :withPos(10, -4, -6)
  local tridentConfig = viewConfig:new()
      :withScale(1)
      :withRot(-90, 0, -235)
      :withPos(11, -0.5, -18)

  return config
      :withBlockConfig(blockConfig)
      :withItemConfig(itemConfig)
      :withToolConfig(toolConfig)
      :withFoodConfig(itemConfig)
      :withArmorConfig(itemConfig)
      :withExactConfig(
        itemConfig,
        "minecraft:lantern",
        "minecraft:soul_lantern",
        "minecraft:chain",
        "minecraft:iron_bars",
        "minecraft:pointed_dripstone",
        "minecraft:brown_mushroom",
        "minecraft:red_mushroom",
        "minecraft:crimson_fungus", "minecraft:warped_fungus",
        "minecraft:short_grass",
        "minecraft:tall_grass",
        "minecraft:dead_bush",
        "minecraft:sugar_cane",
        "minecraft:bamboo",
        "minecraft:cocoa_beans",
        "minecraft:pitcher_pod",
        "minecraft:kelp",
        "minecraft:nether_wart",
        "minecraft:lily_pad",
        "minecraft:seagrass",
        "minecraft:sea_pickle",
        "minecraft:poppy",
        "minecraft:dandelion",
        "minecraft:blue_orchid",
        "minecraft:allium",
        "minecraft:azure_bluet",
        "minecraft:oxeye_daisy",
        "minecraft:cornflower", "minecraft:lily_of_the_valley",
        "minecraft:wither_rose",
        "minecraft:pink_petals",
        "minecraft:sunflower",
        "minecraft:lilac",
        "minecraft:rose_bush",
        "minecraft:peony",
        "minecraft:pitcher_plant",
        "minecraft:crimson_roots",
        "minecraft:warped_roots",
        "minecraft:nether_sprouts", "minecraft:hanging_roots",
        "minecraft:glow_lichen",
        "minecraft:frogspawn",
        "minecraft:turtle_egg",
        "minecraft:sniffer_egg",
        "minecraft:cobweb",
        "minecraft:sculk_vein",
        "minecraft:flower_pot",
        "minecraft:brewing_stand",
        "minecraft:cauldron",
        "minecraft:bell",
        "minecraft:ladder",
        "minecraft:redstone",
        "minecraft:repeater",
        "minecraft:comparator",
        "minecraft:lever",
        "minecraft:tripwire_hook",
        "minecraft:hopper",
        "minecraft:string"
      )
      :withExactConfig(spyglassConfig, "minecraft:spyglass")
      :withExactConfig(bowConfig, "minecraft:bow")
      :withExactConfig(crossbowConfig, "minecraft:crossbow")
      :withExactConfig(shieldConfig, "minecraft:shield")
      :withExactConfig(tridentConfig, "minecraft:trident")
      :withContainsConfig(blockConfig, "coral_block")
      :withContainsConfig(
        itemConfig,
        "door",
        "campfire",
        "pane",
        "candle",
        "_bud",
        "sapling",
        "propagule",
        "vine",
        "fern",
        "tulip",
        "seeds",
        "berries",
        "_coral",
        "torch",
        "sign",
        "rail",
        "pattern"
      )
      :withContainsConfig(toolConfig, "sword", "mace")
      :withContainsConfig(bedConfig, "bed")
      :withContainsConfig(bannerConfig, "banner")
end

---@overload fun(): BruhAPI.ItemView.Config
---@param hide boolean
---@return BruhAPI.ItemView.Config
function itemViewConfig:withHideOnSelectedMainHand(hide)
  if hide == nil then
    hide = true
  end
  return with(self, "hideOnSelectedMainHand", hide)
end

---@overload fun(): BruhAPI.ItemView.Config
---@param hide boolean
---@return BruhAPI.ItemView.Config
function itemViewConfig:withHideOnSelectedOffHand(hide)
  if hide == nil then
    hide = true
  end
  return with(self, "hideOnSelectedOffHand", hide)
end

---@param config BruhAPI.ItemView.ViewConfig
---@return BruhAPI.ItemView.Config
function itemViewConfig:withBlockConfig(config)
  return with(self, "block", config)
end

---@param config BruhAPI.ItemView.ViewConfig
---@return BruhAPI.ItemView.Config
function itemViewConfig:withItemConfig(config)
  return with(self, "item", config)
end

---@param config BruhAPI.ItemView.ViewConfig
---@return BruhAPI.ItemView.Config
function itemViewConfig:withToolConfig(config)
  return with(self, "tool", config)
end

---@param config BruhAPI.ItemView.ViewConfig
---@return BruhAPI.ItemView.Config
function itemViewConfig:withFoodConfig(config)
  return with(self, "food", config)
end

---@param config BruhAPI.ItemView.ViewConfig
---@return BruhAPI.ItemView.Config
function itemViewConfig:withArmorConfig(config)
  return with(self, "armor", config)
end

---@param config BruhAPI.ItemView.ViewConfig
---@param ... string
---@return BruhAPI.ItemView.Config
function itemViewConfig:withContainsConfig(config, ...)
  ---@type table<string, BruhAPI.ItemView.ViewConfig>
  local copy = {}
  for key, value in pairs(self.containsItem) do
    copy[key] = value
  end

  local ids = { ... }
  for _, id in ipairs(ids) do
    copy[id] = config
  end

  return with(self, "containsItem", copy)
end

---@param config BruhAPI.ItemView.ViewConfig
---@param ... string
---@return BruhAPI.ItemView.Config
function itemViewConfig:withExactConfig(config, ...)
  ---@type table<string, BruhAPI.ItemView.ViewConfig>
  local copy = {}
  for key, value in pairs(self.exactItem) do
    copy[key] = value
  end

  local ids = { ... }
  for _, id in ipairs(ids) do
    copy[id] = config
  end

  return with(self, "exactItem", copy)
end

---@param callback fun(ItemStack, ItemTask): boolean
---@return BruhAPI.ItemView.Config
function itemViewConfig:withCustom(callback)
  ---@type (fun(ItemStack, ItemTask): boolean)[]
  local copy = {}
  for i = 1, #self.custom do
    local value = self.custom[i]
    copy[i] = value
  end

  table.insert(copy, callback)

  return with(self, "custom", copy)
end

return itemViewConfig
