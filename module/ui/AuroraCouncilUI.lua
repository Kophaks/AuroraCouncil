AuroraCouncilUI = {};

function AuroraCouncilUI:Export()
    local _ui = {};

    -- PUBLIC
    _ui.LootMasterFrame = AuroraCouncilLootMasterFrame:Export();

    -- PUBLIC END


    return _ui;
end