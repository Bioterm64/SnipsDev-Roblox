<!-- Html tags in md? -->
# <div style="display: flex; align-items: center"><img src="https://github.com/Bioterm64/SnipsDev-Roblox/blob/main/source/assets/logo.png?raw=true" height="64" style="margin-right: 1rem"><span>SnipsDev-Roblox</span></div>

Use snippets in roblox through a module script. (Alpha)

## Installation
You may install them from the Marketplace: 
https://create.roblox.com/store/asset/70557019570715/SnipsDev

Or get the plugin from [here](/source/) and place it on your plugins folder.

## Usage
- This is an example code on what is possible.
  * Go to the `plugins` tab in roblox studio.
  * Go to `SnipsDev` section and click `Manage` to open the snippets file.
  * Paste this code. Read the [wiki](https://github.com/Bioterm64/SnipsDev-Roblox/wiki) to know what is possible.
  
```lua
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
```

### Purpose of the Project
This project is to provide a much flexible, easy, and managable way to write your snippets through code.
Since most in the marketplace are either written in a bad style or its paid, I decided to create this project just for me and you to enjoy simplicity.
It is a skill issue to make a such complicated and unmaintainable code.
