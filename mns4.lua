setfpscap(5)
script_key = "YWLeSZotsWPngunFxSxgmyNfuViyvcJa";
_G.GPROGRESS_MODE = "Hybrid"
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
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/34915da4ad87a5028e1fd64efbe3543f.lua"))()