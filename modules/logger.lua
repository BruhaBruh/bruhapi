---@overload fun(v: any, pretty: boolean): BruhAPI.Logger
---@param v any
---@param pretty boolean
---@param base_offset string
---@param in_object boolean
---@return string
local function string_value(v, pretty, base_offset, in_object)
  if base_offset == nil then
    base_offset = ""
  end
  if in_object == nil then
    in_object = false
  end

  local v_type = type(v)
  local offset = base_offset .. "  "
  local base_space = "\n" .. base_offset
  local space = "\n" .. offset

  if v_type == "nil" then
    return "nil"
  elseif v_type == "boolean" or v_type == "number" then
    return tostring(v)
  elseif v_type == "string" then
    if in_object then
      return "\"" .. tostring(v) .. "\""
    end
    return tostring(v)
  elseif v_type == "table" then
    local is_array = true
    local max_index = 0

    for k, _ in pairs(v) do
      if type(k) ~= "number" then
        is_array = false
        break
      else
        if k > max_index then
          max_index = k
        end
      end
    end

    if is_array then
      local parts = {}
      for i = 1, max_index do
        table.insert(parts, string_value(v[i], pretty, offset, true))
      end

      if pretty then
        return "[" .. space .. table.concat(parts, "," .. space) .. base_space .. "]"
      end
      return "[ " .. table.concat(parts, ", ") .. " ]"
    else
      local keys = {}
      for k in pairs(v) do
        table.insert(keys, k)
      end
      table.sort(keys, function(a, b)
        if type(a) == type(b) then
          return tostring(a) < tostring(b)
        else
          return type(a) < type(b)
        end
      end)

      local parts = {}
      for _, k in ipairs(keys) do
        local key_str = tostring(k)
        local val_str = string_value(v[k], pretty, offset, true)
        table.insert(parts, key_str .. "=" .. val_str)
      end

      if pretty then
        return "{" .. space .. table.concat(parts, "," .. space) .. base_space .. "}"
      end
      return "{ " .. table.concat(parts, ", ") .. " }"
    end
  else
    -- Для функций, userdata и thread возвращаем тип
    return "<" .. v_type .. ">"
  end
end


---@class BruhAPI.Logger
---@field pretty boolean
---@field level number 0 - DEBUG 1 - INFO 2 - WARN 3 - ERROR 4 - CRITICAl
local logger = {
  pretty = false,
  level = 1
}
logger.__index = logger

local levels = {
  debug = 0,
  info = 1,
  warn = 2,
  error = 3,
  critical = 4,
}

---@param level number
---@return BruhAPI.Logger
function logger:new(level)
  local self = setmetatable({}, logger)
  self.level = level or 1
  return self
end

---@param pretty boolean
---@return BruhAPI.Logger
function logger:setPretty(pretty)
  self.pretty = pretty
  return self
end

---@overload fun(): BruhAPI.Logger
---@param pretty boolean
---@return BruhAPI.Logger
function logger:withPretty(pretty)
  local instance = setmetatable({}, getmetatable(self))

  for k, v in pairs(self) do
    instance[k] = v
  end

  if pretty == nil then
    pretty = true
  end

  instance.pretty = pretty

  return instance
end

---@param msg any
---@param ... any
function logger:log(msg, ...)
  local count = 1 + select("#", ...)
  local args = {}

  for i = 1, count do
    local val
    if i == 1 then
      val = msg
    else
      val = select(i - 1, ...)
    end
    args[i] = string_value(val, self.pretty)
  end
  local output = table.concat(args, " ")
  print(output)
end

---@param ... any
function logger:debug(...)
  if self.level <= levels.debug then
    self:log("[DEBUG]", ...)
  end
end

---@param ... any
function logger:info(...)
  if self.level <= levels.info then
    self:log("[INFO]", ...)
  end
end

---@param ... any
function logger:warn(...)
  if self.level <= levels.warn then
    self:log("[WARN]", ...)
  end
end

---@param ... any
function logger:error(...)
  if self.level <= levels.error then
    self:log("[ERROR]", ...)
  end
end

---@param ... any
function logger:critical(...)
  if self.level <= levels.critical then
    self:log("[CRITICAL]", ...)
  end
end

return logger
