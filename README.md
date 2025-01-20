# SnipsDev-Roblox
Use snippets in roblox through a module script.

## Usage
To use this plugin, click on the `Manage Snippets` button in the plugins tab to open the editor. You must provide valid code that returns the following format:

```lua
{
  <snippet_entry: string> = {
    prefix: string
    body: string
    description: string  (optional)
    kind: Enum.CompletionItemKind | string  (optional)
  },
  ...
}
```
where as: 
- `prefix: string`: The prefix of this snippet.

- `body: string`: The snippet code to use. Example:
```lua
["Get player's CurrentCamera"] = {
  prefix = "get_cam",
  body = "local currentCamera = workspace.CurrentCamera",
}
```

- `description: string  (optional)`: The description of this snippet.

- - `kind: Enum.CompletionItemKind | string  (optional)`: The kind of this snippet. (default: Enum.CompletionItemKind.Snippet). Example:
```lua
['Clone Item'] = {
  prefix = "f_clone",
  body =
[[
local function cloneTo(instance, parent)
  local clone = instance:Clone()
  clone.Parent = parent
  return clone
end
]],
  kind = "Function",  -- Enum.CompletionItemKind.Function is also valid
  description = "Snippet of a clone function."
}
```
### Sample Code
```lua
return {
  ['Get the ReplicatedStorage'] = {
    prefix = "g_replicated",
    body = "local ReplicatedStorage = game:GetService("ReplicatedStorage")",
    kind = Enum.CompletionItemKind.Snippet,
    description = "Snippet for ReplicationStorage",
  },
  ['Get the ReplicationFirst'] = {
    prefix = "g_replicated",
    body = "local ReplicationFirst = game:GetService("ReplicationFirst")",
    kind = Enum.CompletionItemKind.Snippet,
    description = "Snippet for ReplicationFirst",
  }
}
```

### Sample Code (Dynamic)
The snippets are stored in a module script and loaded with `require()`. Your snippets script will run and have undesired consequences. Because of that behavior, we can write dynamic snippets like this.
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

## Presets
Presets are available in this github page in the [presets](/presets/) folder.
Feel free to contribute your own presets.

Incase I don't merge them in the main branch (since I'm busy), just check people's presets in the `pull requests` tab in this github page.

# Purpose of this project
Since I can't really find a snippet plugin that is free and also this easy, I created this on my own. :)
