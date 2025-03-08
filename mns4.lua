repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer
local plr = game.Players.LocalPlayer
repeat wait() until plr.Character
repeat wait() until plr.Character:FindFirstChild("HumanoidRootPart")
repeat wait() until plr.Character:FindFirstChild("Humanoid")
repeat wait() until workspace:FindFirstChild("__THINGS")

local vu = game:GetService("VirtualUser")
game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

local ReplicatedStorage = cloneref(game.ReplicatedStorage)
local InstancingCmds = require(ReplicatedStorage.Library.Client.InstancingCmds)
local Network = require(ReplicatedStorage.Library.Client.Network)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local Directory = require(ReplicatedStorage.Library.Directory)
local UltimateCmds = require(ReplicatedStorage.Library.Client.UltimateCmds)

-- Add Orb collection functionality
local Orb = require(ReplicatedStorage.Library.Client.OrbCmds.Orb)
local OldCollectDistance = Orb.CollectDistance
local OldCombineDelay = Orb.CombineDelay
local OldDefaultPickupDistance = Orb.DefaultPickupDistance
local OldCombineDistance = Orb.CombineDistance

-- Set orb collection to max values
Orb.CollectDistance = 9e9
Orb.CombineDelay = 0
Orb.DefaultPickupDistance = 9e9
Orb.CombineDistance = 9e9

-- Hook the orb creation function to auto-collect
local function setupOrbCollection()
    local OrbsCreate = Network.Fired("Orbs: Create")
    
    -- Check if there are connections before trying to hook
    local connections = getconnections(OrbsCreate)
    if #connections > 0 then
        local OrbsCreateFunc = connections[1].Function
        
        -- Hook the function to auto-collect orbs
        local OrbsCreateOld = hookfunction(OrbsCreateFunc, function(t)
            local collect = {}
            for i, v in pairs(t) do
                table.insert(collect, v.id)
            end
            
            -- Collect all orbs immediately
            ReplicatedStorage.Network["Orbs: Collect"]:FireServer(collect)
        end)
    end
end

-- Setup lootbag collection
local function setupLootbagCollection()
    task.spawn(function()
        while task.wait(0.1) do
            pcall(function()
                for _, lootbag in pairs(workspace.__THINGS:FindFirstChild("Lootbags"):GetChildren()) do
                    if lootbag and lootbag:FindFirstChild("Pickup") and lootbag:FindFirstChild("PrimaryPart") then
                        Network.Fire("Lootbags_Claim", lootbag:GetAttribute("ID"))
                        lootbag:Destroy()
                    end
                end
            end)
        end
    end)
end

local function isInstanceLoaded()
    if not InstancingCmds.IsInInstance() then return false end
    local things = workspace:FindFirstChild("__THINGS")
    if not things then return false end
    local instances = things:FindFirstChild("Instances")
    if not instances then return false end
    local luckyWorld = instances:FindFirstChild("LuckyEventWorld")
    if not luckyWorld then return false end
    local spawns = luckyWorld:FindFirstChild("BREAKABLE_SPAWNS")
    if not spawns then return false end
    local mainSpawn = spawns:FindFirstChild("Main_1")
    if not mainSpawn then return false end
    return true
end

local function gotoOptimalPosition()
    local farmingAreaPos = workspace.__THINGS.Instances.LuckyEventWorld.BREAKABLE_SPAWNS.Main_1.CFrame.Position
    
    local eggPos
    local customEggs = workspace.__THINGS:FindFirstChild("CustomEggs")
    if customEggs then
        for _, egg in pairs(customEggs:GetChildren()) do
            if egg:IsA("Model") then
                local success, result = pcall(function() return egg:GetPivot().Position end)
                if success then
                    eggPos = result
                    break
                end
            elseif egg:IsA("BasePart") then
                eggPos = egg.Position
                break
            end
        end
    end
    
    if not eggPos then eggPos = farmingAreaPos + Vector3.new(0, 0, 50) end
    
    local midPos = farmingAreaPos:Lerp(eggPos, 0.4) + Vector3.new(0, 2, 0)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(midPos)
    
    task.wait(0.2)
    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.MoveDirection.Magnitude < 0.1 then
            midPos = farmingAreaPos:Lerp(eggPos, 0.5) + Vector3.new(0, 3, 0)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(midPos)
        end
    end
end

local function hideEggAnimation()
    local function deleteEggAnimation()
        local eggOpenAnimation = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("EggOpenAnimation")
        if eggOpenAnimation then eggOpenAnimation:Destroy() end
    end
    
    deleteEggAnimation()
    
    task.spawn(function()
        while task.wait(0.05) do deleteEggAnimation() end
    end)
    
    game:GetService("Players").LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
        if child.Name == "EggOpenAnimation" then child:Destroy() end
    end)
    
    local eggAssets = {"Opening", "Pet", "TapToOpen", "Modifier"}
    
    for _, assetName in ipairs(eggAssets) do
        local asset = game:GetService("ReplicatedStorage").Assets.UI.Eggs:FindFirstChild(assetName)
        if asset then
            local backup = asset:Clone()
            asset:Destroy()
            
            task.spawn(function()
                while task.wait(1) do
                    asset = game:GetService("ReplicatedStorage").Assets.UI.Eggs:FindFirstChild(assetName)
                    if asset then asset:Destroy() end
                end
            end)
        end
    end
end

local function enableAutoFarm()
    local autoPetsButton = game:GetService("Players").LocalPlayer.PlayerGui.MainLeft.Left.Tools.AutoPets
    
    if autoPetsButton then
        local events = {"MouseButton1Click", "Activated"}
        
        for _, event in ipairs(events) do
            for _, connection in pairs(getconnections(autoPetsButton[event])) do
                connection:Fire()
            end
        end
    end
end

local function useUltimates()
    local availableUltimates = {}
    
    if UltimateCmds and UltimateCmds.UltimatesUnlocked and UltimateCmds.UltimatesUnlocked() then
        local equippedUltimate = UltimateCmds.GetEquippedItem and UltimateCmds.GetEquippedItem()
        if equippedUltimate then
            table.insert(availableUltimates, equippedUltimate:GetId())
        elseif Directory and Directory.Ultimates then
            for ultimateId, _ in pairs(Directory.Ultimates) do
                table.insert(availableUltimates, ultimateId)
            end
        end
    end
    
    if #availableUltimates > 0 then
        task.spawn(function()
            while task.wait(5) do
                for _, ultimateId in ipairs(availableUltimates) do
                    if UltimateCmds.IsCharged and UltimateCmds.IsCharged(ultimateId) and not UltimateCmds.IsActive(ultimateId) then
                        local success = UltimateCmds.Activate(ultimateId)
                        if not success then Network.Invoke("Ultimates: Activate", ultimateId) end
                        break
                    end
                end
            end
        end)
    end
end

local function placeFlag()
    task.spawn(function()
        while task.wait(2) do
            pcall(function()
                -- Get the player's inventory
                local SaveModule = require(ReplicatedStorage.Library.Client.Save)
                local playerSave = SaveModule.Get()
                
                if playerSave and playerSave.Inventory then
                    -- Only try to place Coins Flag
                    local flagType = "Coins Flag"
                    
                    -- Look through all inventory categories
                    for category, items in pairs(playerSave.Inventory) do
                        for uid, item in pairs(items) do
                            -- Check if this is the Coins Flag
                            if item.id == flagType then
                                -- Try to place the flag using its UID
                                local success = Network.Invoke("FlexibleFlags_Consume", flagType, uid)
                                
                                if success then
                                    print("Successfully placed Coins Flag with UID: " .. uid)
                                    return
                                end
                                
                                -- If that didn't work, try without the UID
                                success = Network.Invoke("FlexibleFlags_Consume", flagType)
                                if success then
                                    print("Successfully placed Coins Flag without UID")
                                    return
                                end
                            end
                        end
                    end
                    
                    -- If we couldn't find Coins Flag in inventory, try direct approach
                    local success = Network.Invoke("FlexibleFlags_Consume", flagType)
                    if success then
                        print("Successfully placed Coins Flag directly")
                        return
                    end
                end
            end)
        end
    end)
end

local function purchaseEventUpgrades()
    local upgrades = {
        "LuckyRaidPets", "LuckyRaidDamage", "LuckyRaidAttackSpeed", "LuckyRaidPetSpeed",
        "LuckyRaidEggCost", "LuckyRaidMoreCurrency", "LuckyRaidXP", "LuckyRaidBetterLoot",
        "LuckyRaidHugeChest", "LuckyRaidTitanicChest"
    }
    
    task.spawn(function()
        while true do
            for _, upgrade in ipairs(upgrades) do
                local success = Network.Invoke("EventUpgrades: Purchase", upgrade)
                if success then print("Bought: " .. upgrade) end
                task.wait(0.1)
            end
            task.wait(1)
        end
    end)
end

local function hatchLuckyEventEgg()
    local luckyEventEggId = nil
    
    for eggId, eggData in pairs(Directory.Eggs) do
        if eggData.name and string.find(string.lower(eggData.name), "lucky") then
            luckyEventEggId = eggId
            break
        end
    end
    
    local function attemptHatching()
        local customEggs = workspace.__THINGS:FindFirstChild("CustomEggs")
        if customEggs then
            for _, egg in pairs(customEggs:GetChildren()) do
                if egg:IsA("Model") then
                    local eggUid = egg.Name
                    local maxHatch = EggCmds.GetMaxHatch()
                    Network.Invoke("CustomEggs_Hatch", eggUid, maxHatch)
                end
            end
        end
    end
    
    for i = 1, 5 do
        task.spawn(function()
            while true do
                attemptHatching()
                task.wait(0.05)
            end
        end)
    end
end

local function applyOptimizations()
    pcall(function()
        game:GetService("RunService"):Set3dRenderingEnabled(false)
        
        pcall(function() 
            settings().Rendering.QualityLevel = 1
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
            settings().Rendering.EagerBulkExecution = false
        end)
        
        pcall(function()
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").ShadowSoftness = 0
            game:GetService("Lighting").Technology = Enum.Technology.Compatibility
        end)
        
        pcall(function()
            local UserSettings = UserSettings()
            local GameSettings = UserSettings.GameSettings
            GameSettings.SavedQualityLevel = 1
        end)
    end)
end

setthreadidentity(2)
if not InstancingCmds.IsInInstance() then InstancingCmds.Enter("LuckyEventWorld") end

local maxWaitTime = 15
local startTime = os.time()

repeat
    task.wait(0.1)
    if os.time() - startTime > maxWaitTime then break end
until isInstanceLoaded()

setthreadidentity(7)

task.wait(1)
hideEggAnimation()
gotoOptimalPosition()
task.wait(1)
enableAutoFarm()
task.wait(0.5)
applyOptimizations()
task.wait(0.1)
useUltimates()
task.wait(0.1)
placeFlag()
task.wait(0.1)
purchaseEventUpgrades()
task.wait(0.1)
setupOrbCollection()
setupLootbagCollection()
task.wait(0.1)
hatchLuckyEventEgg()
