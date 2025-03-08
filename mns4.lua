-- Wait for the player to load and the game to load
if not game.Players.LocalPlayer:GetAttribute("__LOADED") then
    game.Players.LocalPlayer:GetAttributeChangedSignal("__LOADED"):Wait()
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Get the local player
local player = game.Players.LocalPlayer

-- Wait for the player's character to load
local character = player.Character or player.CharacterAdded:Wait()

-- Function to teleport the player to a specific CFrame
local function teleportToCFrame(targetCFrame)
    if character and targetCFrame then
        character:SetPrimaryPartCFrame(targetCFrame)
    else
        warn("Character or teleport location not found!")
    end
end

-- Function to check if Main_1 exists in the BREAKABLE_SPAWNS folder
local function isMain1Valid()
    return workspace.__THINGS.Instances.LuckyEventWorld.BREAKABLE_SPAWNS:FindFirstChild("Main_1") ~= nil
end

-- First teleport: Teleport to workspace.__THINGS.Instances.LuckyEventWorld.Teleports.Enter.CFrame
if workspace.__THINGS.Instances.LuckyEventWorld.Teleports.Enter then
    teleportToCFrame(workspace.__THINGS.Instances.LuckyEventWorld.Teleports.Enter.CFrame)
else
    warn("First teleport location not found!")
end

-- Wait for 5 seconds
wait(5)

-- Continuously check for Main_1 and repeat the first teleport if it doesn't exist
while not isMain1Valid() do
    warn("Main_1 is not a valid member of BREAKABLE_SPAWNS. Repeating first teleport...")
    
    -- Repeat the first teleport
    if workspace.__THINGS.Instances.LuckyEventWorld.Teleports.Enter then
        teleportToCFrame(workspace.__THINGS.Instances.LuckyEventWorld.Teleports.Enter.CFrame)
    else
        warn("First teleport location not found!")
        break -- Exit the loop if the first teleport location is missing
    end

    -- Wait for 5 seconds before checking again
    wait(5)
end

-- Second teleport: Teleport to workspace.__THINGS.Instances.LuckyEventWorld.BREAKABLE_SPAWNS.Main_1.CFrame
if isMain1Valid() then
    teleportToCFrame(workspace.__THINGS.Instances.LuckyEventWorld.BREAKABLE_SPAWNS.Main_1.CFrame)
else
    warn("Main_1 is still not valid. Teleportation aborted.")
end

-- Function to purchase upgrades
local function purchaseUpgrades()
    local upgrades = {
        "LuckyRaidPets",
        "LuckyRaidDamage",
        "LuckyRaidAttackSpeed",
        "LuckyRaidPetSpeed",
        "LuckyRaidEggCost",
        "LuckyRaidMoreCurrency",
        "LuckyRaidXP",
        "LuckyRaidBetterLoot",
        "LuckyRaidHugeChest",
        "LuckyRaidTitanicChest"
    }

    -- Loop through each upgrade and purchase it
    for _, upgrade in pairs(upgrades) do
        game:GetService("ReplicatedStorage").Network["EventUpgrades: Purchase"]:InvokeServer(upgrade)
        wait(1) -- Add a 1-second delay between each purchase
    end
end

-- Continuously purchase upgrades after teleporting to Main_1
while true do
    if isMain1Valid() then
        purchaseUpgrades()
    else
        warn("Main_1 is no longer valid. Stopping upgrades.")
        break
    end
    wait(5) -- Wait 5 seconds before attempting to purchase upgrades again
end
