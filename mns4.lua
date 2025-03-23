setfpscap(5)
script_key = "YWLeSZotsWPngunFxSxgmyNfuViyvcJa";
_G.GPROGRESS_MODE = "Hybrid"
_G.GDO_MINING_EVENT = true
_G.GGFX_MODE = 1
_G.GRANK_TO = 33
_G.GZONE_TO = 99 -- ONLY increase above 99 to go to world2, only when 100% sure, there is no way back for the "best zone" quests etc. 
_G.GMAX_EGG_SLOTS = 99
_G.GMAX_EQUIP_SLOTS = 99
_G.GHOLD_GIFTS = false
_G.GHOLD_BUNDLES = false
_G.GIGNORE_SLEDRACE = true
_G.GPOTIONS = {"Damage","Coins"}
_G.GENCHANTS = {"Tap Power", "Coins", "Treasure Hunter", "Strong Pets", "Criticals"}
_G.GFRUITS = {"Apple","Banana","Orange","Rainbow","Pineapple","Watermelon"}
_G.GWEBHOOK_USERID = "667064890359545917" -- your discord userID, rightclick your user & copy it, might need to enable DEV settings in discord.
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1326991100141113414/3RBEws1Oe8oJ2nPRBjgmbKpIQ3NrRX82qVoOHeHOC7mVIvh2CpCZYgWZHmzvKK_rjZFe" -- a webhook on your private discord channel.
_G.GMAIL_RECEIVERS = {"ProfiAzUr"} -- for Mailing items/pets
_G.GMAIL_ITEMS = {
["Sapphire Gem"] = {Class = "Misc", Id = "Sapphire Gem", MinAmount = 1000},
["Ruby Gem"] = {Class = "Misc", Id = "Ruby Gem", MinAmount = 750},
["Emerald Gem"] = {Class = "Misc", Id = "Emerald Gem", MinAmount = 5},
["Amethyst Gem"] = {Class = "Misc", Id = "Amethyst Gem", MinAmount = 1},
["Rainbow Gem"] = {Class = "Misc", Id = "Rainbow Gem", MinAmount = 1},
["All Huges"] = {Class = "Pet", Id = "All Huges", MinAmount = 1},
["Send Diamonds"] = {Class = "Currency", Id = "Diamonds", KeepAmount = "1m", MinAmount = "25m"}, -- mail diamonds, to enable lower MinAmount..
["Lucky gift"] = {Class = "Lootbox", Id = "Lucky Gift", MinAmount = 50},
["Hype Egg 2"] = {Class = "Lootbox", Id = "Hype Egg 2", MinAmount = 1},
["Daycare egg 5"] = {Class = "Egg", Id = "Huge Machine Egg 5", MinAmount = 1},
["Secret pet1"] = {Class = "Pet", Id = "Rainbow Swirl", MinAmount = 1, AllVariants = true},
["Secret pet2"] = {Class = "Pet", Id = "Banana", MinAmount = 1, AllVariants = true},
["Secret pet3"] = {Class = "Pet", Id = "Coin", MinAmount = 1, AllVariants = true},
["Secret pet4"] = {Class = "Pet", Id = "Lucky Block", MinAmount = 1, AllVariants = true},
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/34915da4ad87a5028e1fd64efbe3543f.lua"))()
