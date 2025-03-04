<!-- Html tags in md? -->
# <div style="display: flex; align-items: center"><img src="https://github.com/Bioterm64/SnipsDev-Roblox/blob/main/source/assets/logo.png?raw=true" height="64" style="margin-right: 1rem"><span>SnipsDev-Roblox</span></div>

Use snippets in roblox through a module script. (Alpha)

## Installation
You may install them from the Marketplace: 
https://create.roblox.com/store/asset/70557019570715/SnipsDev

Or get the plugin from [here](/source/) and place it on your plugins folder.

## Usage
To use this plugin, click on the `Manage Snippets` button in the plugins tab to open the editor. You must provide valid code that returns the following format:

```lua
{
  <snippet_entry: string> = {
    prefix: string
    body: string
    description: string?
    kind: (Enum.CompletionItemKind | string)?,
    link: string?,
    example: string?,
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

- `description: string?`: The description of this snippet.
> `?` means optional for new devs. Example: `string?`

- `kind: (Enum.CompletionItemKind | string)?`: The kind of this snippet. (default: `Enum.CompletionItemKind.Snippet`). Example:
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

- `link: string?`: A link to the documentation in creator hub.
> Note: It will not work when you provide other links besides from https://create.roblox.com/

Example:
```lua
['Get the ReplicatedStorage'] = {
  prefix = "g_replicated",
  body = "local ReplicatedStorage = game:GetService("ReplicatedStorage")",
  link = "https://create.roblox.com/docs/reference/engine/classes/ReplicatedStorage",
},
```

- `example: string?`: An example on how this snippet should be used. (default: <this snippet's body>).
Example: 
```lua
["Get Service: LocalPlayer"] = {
	prefix = ":LocalPlayer",
	body = "local LocalPlayer = game:GetService('LocalPlayer').LocalPlayer",
	description = "Snippet for getting LocalPlayer",
	example = [[
local LocalPlayer = game:GetService('LocalPlayer').LocalPlayer

LocalPlayer.CharacterAdded:Connect(function(character)
	local head = character:FindFirstChild("Head")
	head.Color3 = Color3.new(1, 0, 0)
	-- do something else...
end)
]]
}
```

### Summary
| Name | Description |
| ---- | ----------- |
| `prefix` (required) | The prefix of the snippet. It will be used to auto-complete the snippet. |
| `body` (required) | The snippet code to use. |
| `description` | The description of this snippet. |
| `kind` | The kind of this snippet. (default: `Enum.CompletionItemKind.Snippet`) |
| `link` | A link to the documentation in creator hub. |
| `example` | An example on how this snippet should be used. (default: `body`). 

## Sample Code
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

### Dynamic Sample
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

### Purpose of the Project
This project aims to provide a more flexible, easy, and manageable way to write code snippets. Since most available options in the marketplace are either poorly written or paid, I decided to create this project for both myself and others to enjoy the simplicity of coding. Writing overly complicated and unmaintainable code is simply a **skill issue**.
