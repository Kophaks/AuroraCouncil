AuroraCouncilRaidResponseFrame = {}

function AuroraCouncilRaidResponseFrame:Export()
    local _frame = {}

    local frameBuffer = {};

    function _frame:OpenRaidResponseFrame()
        local frame = tremove(frameBuffer)
        if not frame then
            self:CreateRaidResponseFrame();
        else
            self:ResetRaidResponseFrame();
        end
    end

    function _frame:CreateRaidResponseFrame()
        CreateFrame("Frame", "AUCO_RaidResponseFrame", UIParent);
    end

    function _frame:ResetRaidResponseFrame()
        AUCO_RaidResponseFrame:Show();
    end

    function _frame:CloseRaidResponseFrame()
        AUCO_RaidResponseFrame:Hide()
        tinsert(frameBuffer, AUCO_RaidResponseFrame)
    end

    return _frame;
end