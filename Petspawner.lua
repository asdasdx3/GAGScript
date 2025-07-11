-- Add Rayfield notifications to show user feedback during spawning

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Initialize Spawner (assuming this is how you access the Spawner module)
local Spawner = {
    GetPets = function() return {"Raccoon", "Mimic Octopus", "Dragonfly", "Disco Bee", "Butterfly", "Red Fox", "Queen Bee",} end, -- Example pet list
    GetSeeds = function() return {"Candy Blossom", "Sunflower",} end, -- Example seed list
    SpawnPet = function(pet, kg, age) print("Spawning Pet: "..pet.." with "..kg.."KG and age "..age) end,
    SpawnSeed = function(seed) print("Spawning Pet: "..seed) end,
    SpawnEgg = function(egg) print("Spawning Pet: "..egg) end,
    Spin = function(item) print("Spawning Pet: "..item) end,
    Load = function() print("Loading default UI") end
}

local Window = Rayfield:CreateWindow({
    Name = "🐾Pet🐾 Spawner UI - Made by Dymbs",
    Icon = 0,
    LoadingTitle = "Pet Spawner",
    LoadingSubtitle = "by Dymbs",
    ShowText = "Pet Spawner",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "PetSpawnerConfig"
    }
})

-- Main Spawner Tab
local MainTab = Window:CreateTab("Main", 0)

-- Pet Spawning Section
local PetSection = MainTab:CreateSection("Pet Spawning")
local PetDropdown = MainTab:CreateDropdown({
    Name = "Select Pet",
    Options = Spawner.GetPets(),
    CurrentOption = "Raccoon",
    Flag = "PetSelection",
    Callback = function(Value) end
})

local KgInput = MainTab:CreateInput({
    Name = "KG",
    PlaceholderText = "2",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text) end,
})

local AgeInput = MainTab:CreateInput({
    Name = "Age",
    PlaceholderText = "2",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text) end,
})

MainTab:CreateButton({
    Name = "Spawn Pet",
    Callback = function()
        Rayfield:Notify({
            Title = "Spawning Pet",
            Content = "Wait a while...",
            Duration = 2
        })
        local success, err = pcall(function()
            local pet = Rayfield.Flags["PetSelection"].CurrentOption
            local kg = tonumber(KgInput:GetText()) or 1
            local age = tonumber(AgeInput:GetText()) or 1
            Spawner.SpawnPet(pet, kg, age)
        end)
        if not success then
            warn("Spawning Pet")
        end
    end,
})

-- Seed Spawning Section
local SeedSection = MainTab:CreateSection("Seed Spawning")
local SeedDropdown = MainTab:CreateDropdown({
    Name = "Select Seed",
    Options = Spawner.GetSeeds(),
    CurrentOption = "Candy Blossom",
    Flag = "SeedSelection",
    Callback = function(Value) end
})

MainTab:CreateButton({
    Name = "Spawn Seed",
    Callback = function()
        Rayfield:Notify({
            Title = "Spawning Seed",
            Content = "Wait a while...",
            Duration = 2
        })
        local success, err = pcall(function()
            local seed = Rayfield.Flags["SeedSelection"].CurrentOption
            Spawner.SpawnSeed(seed)
        end)
        if not success then
            warn("Spawning Pet")
        end
    end,
})

-- Egg Spawning Section
local EggSection = MainTab:CreateSection("Egg Spawning")
MainTab:CreateButton({
    Name = "Spawn Night Egg",
    Callback = function()
        Rayfield:Notify({
            Title = "Spawning Night Egg",
            Content = "Wait a while...",
            Duration = 2
        })
        local success, err = pcall(function()
            Spawner.SpawnEgg("Night Egg")
        end)
        if not success then
            warn("Spawning Pet")
        end
    end,
})

-- Load default UI when script starts
Spawner.Load()
