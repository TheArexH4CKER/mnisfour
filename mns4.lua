setfpscap(5)
script_key = "YWLeSZotsWPngunFxSxgmyNfuViyvcJa";
_G.GPROGRESS_MODE = "Hybrid"
_G.GDO_LUCKY_WORLD_EVENT = true
_G.GAUTO_RAID = true
_G.GHATCH_LOBBY = true
_G.GMAKE_LUCKY_GIFTS = true
_G.GUSE_LEPRECHAUN_KEYS = true
_G.GMAX_RAID_LEVEL = 100
_G.GMIN_MULTIPLIER = 50 -- which egg to hatch
_G.GEVENT_UPGRADES = {
   "LuckyRaidDamage",
   "LuckyRaidAttackSpeed",
   "LuckyRaidPets",
   "LuckyRaidEggCost",
   "LuckyRaidMoreCurrency",
   "LuckyRaidBetterLoot",
   "LuckyRaidTitanicChest",
   "LuckyRaidHugeChest",
   "LuckyRaidXP",
   --"LuckyRaidPetSpeed",
}
_G.GGFX_MODE = 1
_G.GRANK_TO = 33
_G.GZONE_TO = 999 -- ONLY increase above 99 to go to world2, only when 100% sure, there is no way back for the "best zone" quests etc. 
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
