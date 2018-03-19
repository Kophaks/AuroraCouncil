AuroraCouncilUI = {};

function AuroraCouncilUI:Export()
    local _ui = {};

    -- PUBLIC
    _ui.LootMasterFrame = AuroraCouncilLootMasterFrame:Export();
    _ui.LootOfferFrame = AuroraCouncilLootOfferFrame:Export();
    _ui.RaidResponseFrame = AuroraCouncilRaidResponseFrame:Export();

    -- PUBLIC END


    return _ui;
end