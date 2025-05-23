---@class BruhAPI.ItemView.ViewConfig
---@field scale Vector3
---@field rot Vector3
---@field pos Vector3
local viewConfig = {}
viewConfig.__index = viewConfig


---@param cfg BruhAPI.ItemView.ViewConfig
---@param key string
---@param value any
---@return BruhAPI.ItemView.ViewConfig
local function with(cfg, key, value)
  local instance = setmetatable({}, getmetatable(cfg))

  for k, v in pairs(cfg) do
    instance[k] = v
  end

  instance[key] = value

  return instance
end

---@return BruhAPI.ItemView.ViewConfig
function viewConfig:new()
  local instance = setmetatable({}, viewConfig)
  instance.scale = vec(1, 1, 1)
  instance.rot = vec(0, 0, 0)
  instance.pos = vec(0, 0, 0)
  return instance
end

---@overload fun(Vector3): BruhAPI.ItemView.ViewConfig
---@overload fun(number): BruhAPI.ItemView.ViewConfig
---@param x number
---@param y number
---@param z number
---@return BruhAPI.ItemView.ViewConfig
function viewConfig:withScale(x, y, z)
  local scale = self.scale

  if type(x) == "table" then
    scale = x
  elseif type(x) == "number" and y and z then
    scale = vec(x, y, z)
  elseif type(x) == "number" then
    scale = vec(x, x, x)
  end

  return with(self, "scale", scale)
end

---@overload fun(Vector3): BruhAPI.ItemView.ViewConfig
---@overload fun(number): BruhAPI.ItemView.ViewConfig
---@param x number
---@param y number
---@param z number
---@return BruhAPI.ItemView.ViewConfig
function viewConfig:withRot(x, y, z)
  local rot = self.rot

  if type(x) == "table" then
    rot = x
  elseif type(x) == "number" and y and z then
    rot = vec(x, y, z)
  elseif type(x) == "number" then
    rot = vec(x, x, x)
  end

  return with(self, "rot", rot)
end

---@overload fun(Vector3): BruhAPI.ItemView.ViewConfig
---@overload fun(number): BruhAPI.ItemView.ViewConfig
---@param x number
---@param y number
---@param z number
---@return BruhAPI.ItemView.ViewConfig
function viewConfig:withPos(x, y, z)
  local pos = self.pos

  if type(x) == "table" then
    pos = x
  elseif type(x) == "number" and y and z then
    pos = vec(x, y, z)
  elseif type(x) == "number" then
    pos = vec(x, x, x)
  end

  return with(self, "pos", pos)
end

return viewConfig
