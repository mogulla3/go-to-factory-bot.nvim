local Config = require("go-to-factory-bot.config")
local ModelNameExtractor = require("go-to-factory-bot.model_name_extractor")
local FactoryFinder = require("go-to-factory-bot.factory_finder")

local M = {}

local function go_to_factory_bot()
  local current_line = vim.trim(vim.api.nvim_get_current_line())
  local model_name = ModelNameExtractor.extract(current_line)
  if not model_name then
    return
  end

  local factory_path = FactoryFinder.find_by_model(model_name, Config.definition_file_path, Config.suffix)
  if factory_path then
    vim.api.nvim_command(Config.jump_command .. " " .. factory_path)
  end
end

function M.setup(user_config)
  user_config = user_config or {}
  Config.setup(user_config)

  vim.api.nvim_create_user_command("FactoryBotJump", function()
    go_to_factory_bot()
  end, { nargs = 0, force = true, desc = "Jump to the factory_bot file from the line containing the factory_bot method call." })
end

return M