local config = require("modules.item-view.config")
local viewConfig = require("modules.item-view.view-config")

---@class BruhAPI.ItemView
---@field views ViewPart[]
local itemView = {
  views = {},
}
itemView.config = config
itemView.viewConfig = viewConfig

---@class ViewPart
---@field itemTask ItemTask
---@field slot number
---@field config BruhAPI.ItemView.Config
local viewPart = {}
viewPart.__index = viewPart

---@param pivot ModelPart
---@param slot number
---@param config BruhAPI.ItemView.Config
---@return BruhAPI.ItemView
function itemView:new(
    pivot,
    slot,
    config
)
  local newViewPart = setmetatable({}, getmetatable(viewPart))
  newViewPart.slot = slot
  newViewPart.config = config
  newViewPart.itemTask = pivot:newItem("item" .. slot)
  table.insert(self.views, newViewPart)
  return self
end

function events.tick()
  if not host:isHost() then
    return
  end

  local selectedMainHand = player:getHeldItem(false).id
  local selectedOffHand = player:getHeldItem(true).id

  for _, part in pairs(itemView.views) do
    local newItem = host:getSlot(part.slot - 1)

    local slotItem = {}
    slotItem.id = newItem.id
    slotItem.item = newItem
    if newItem:isTool() then
      slotItem.type = "tool"
    elseif newItem:isFood() then
      slotItem.type = "food"
    elseif newItem:isArmor() then
      slotItem.type = "armor"
    elseif newItem:isBlockItem() then
      slotItem.type = "block"
    else
      slotItem.type = "undefined"
    end

    if slotItem.item == nil then
      part.itemTask:setItem(slotItem.id)
    else
      part.itemTask:setItem(slotItem.item)
    end

    if not (slotItem.id == "minecraft:air") then
      local isComplete = false

      for _, callback in pairs(part.config.custom) do
        isComplete = callback(slotItem.item, part.itemTask)
        if isComplete then break end
      end

      if not isComplete then
        for id, config in pairs(part.config.exactItem) do
          if slotItem.id == id then
            part.itemTask:setScale(config.scale)
            part.itemTask:setRot(config.rot)
            part.itemTask:setPos(config.pos)
            isComplete = true
            break
          end
        end
      end

      if not isComplete then
        for id, config in pairs(part.config.containsItem) do
          if slotItem.id:find(id, 1, true) ~= nil then
            part.itemTask:setScale(config.scale)
            part.itemTask:setRot(config.rot)
            part.itemTask:setPos(config.pos)
            isComplete = true
            break
          end
        end
      end

      if not isComplete then
        if (slotItem.type == "tool") then
          local config = part.config.tool
          part.itemTask:setScale(config.scale)
          part.itemTask:setRot(config.rot)
          part.itemTask:setPos(config.pos)
        elseif (slotItem.type == "block") then
          local config = part.config.block
          part.itemTask:setScale(config.scale)
          part.itemTask:setRot(config.rot)
          part.itemTask:setPos(config.pos)
        elseif (slotItem.type == "food") then
          local config = part.config.food
          part.itemTask:setScale(config.scale)
          part.itemTask:setRot(config.rot)
          part.itemTask:setPos(config.pos)
        elseif (slotItem.type == "armor") then
          local config = part.config.armor
          part.itemTask:setScale(config.scale)
          part.itemTask:setRot(config.rot)
          part.itemTask:setPos(config.pos)
        else
          local config = part.config.item
          part.itemTask:setScale(config.scale)
          part.itemTask:setRot(config.rot)
          part.itemTask:setPos(config.pos)
        end
      end
    end

    local visible = true
    if part.config.hideVirtualOnSelectedMainHand and selectedMainHand == slotItem.id then
      visible = false
    elseif part.config.hideVirtualOnSelectedOffHand and selectedOffHand == slotItem.id then
      visible = false
    end
    part.itemTask:setVisible(visible)
  end
end

return itemView
