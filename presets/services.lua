-- This is free and unencumbered software released into the public domain.
-- Anyone is free to copy, modify, distribute, and perform the work, even for commercial purposes, without asking permission.
-- For more information, please refer to <https://unlicense.org/>

-- Made by @EFiryBoi

local function getAllServices()
  local raw_services = {}
  for _, item in game:GetChildren() do
    pcall(function()
      if item.Name == "Instance" then 
        table.insert(raw_services, item.ClassName) 
        return
      end
      table.insert(raw_services, item.Name)
    end)
  end
  
  local services = {}
  
  for _, item: string in raw_services do
    table.insert(services, (item:gsub("%s+", "")))
  end
  
  return services
end

local allServices = getAllServices()
local snippets = {}

for _, name in allServices do
  snippets["Get Service: "..name] = {
    prefix = ":"..name,
    body = "local "..name.." = game:GetService('"..name.."')",
    description = "Snippet for getting "..name,
    kind = Enum.CompletionItemKind.Snippet,
  }
end

return snippets
