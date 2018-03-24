AuroraCouncilUI = {};

local lootMasterFrame = AuroraCouncilLootMasterFrame:Export();
local lootOfferFrame = AuroraCouncilLootOfferFrame:Export();
local raidResponseFrame = AuroraCouncilRaidResponseFrame:Export();

function AuroraCouncilUI:Export()
    local _ui = {};

    _ui.LootMasterFrame = lootMasterFrame;
    _ui.LootOfferFrame = lootOfferFrame;
    _ui.RaidResponseFrame = raidResponseFrame;


    return _ui;
end