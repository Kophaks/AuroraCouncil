AuroraCouncilUI = {};

function AuroraCouncilUI:Export()
    local _ui = {};

    _ui.LootMasterFrame = AuroraCouncilLootMasterFrame:Export();
    _ui.LootOfferFrame = AuroraCouncilLootOfferFrame:Export();
    _ui.RaidResponseFrame = AuroraCouncilRaidResponseFrame:Export();


    return _ui;
end