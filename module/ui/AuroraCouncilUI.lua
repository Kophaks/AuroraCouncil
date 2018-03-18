AuroraCouncilUI = {}

-- IMPORTS
local councilFrame = AuroraLootMasterFrame:Export()


function AuroraCouncilUI:Export()
    local _ui = {}

    -- PUBLIC
    _ui.councilFrame = councilFrame;

    -- PUBLIC END


    return _ui;
end