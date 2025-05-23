---@class BruhAPI.Utils
local utils = {}

---@param s string
---@return string
function utils:trim(s)
  return s:match("^%s*(.-)%s*$")
end

---@param row 1 | 2 | 3
---@param column 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
---@return number
function utils.inventorySlot(row, column)
  if row < 1 or row > 3 then
    error("invalid row, use row in inclusive range: 1..3")
  end
  if column < 1 or column > 9 then
    error("invalid column, use column in inclusive range: 1..9")
  end

  return 9 + 9 * (row - 1) + column
end

---@param slot 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
---@return number
function utils.hotbarSlot(slot)
  if slot < 1 or slot > 9 then
    error("invalid slot, use slot in inclusive range: 1..9")
  end
  return slot
end

---@param slot 1 | 2 | 3 | 4 1=helmet 2=chestplate 3=leggins 4=boots
---@return number
function utils.armorSlot(slot)
  if slot == 1 then
    return 104
  elseif slot == 2 then
    return 103
  elseif slot == 3 then
    return 102
  elseif slot == 4 then
    return 101
  end
  error("invalid slot, use slot in inclusive range: 1..4")
end

---@return number
function utils.secondArmSlot()
  return 100
end

return utils
