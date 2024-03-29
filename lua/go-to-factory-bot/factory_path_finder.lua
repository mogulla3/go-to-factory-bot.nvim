local Inflector = require("go-to-factory-bot.inflector")

local M = {}

---@param factory_name string
---@param definition_file_path string
---@param suffix string
---@param pluralize_factory_name boolean
---@return string|nil
function M.find_by_name(factory_name, definition_file_path, suffix, pluralize_factory_name)
  local plural_name
  if pluralize_factory_name then
    plural_name = Inflector.pluralize(factory_name)
  else
    plural_name = factory_name
  end

  local factory_file_name
  if suffix ~= "" then
    factory_file_name = plural_name .. "_" .. suffix .. ".rb"
  else
    factory_file_name = plural_name .. ".rb"
  end

  local paths = vim.fs.find(factory_file_name, { path = definition_file_path, type = "file", limit = 1 })

  if not vim.tbl_isempty(paths) then
    return paths[1]
  end
end

return M
