AuroraCouncilLootOfferFrame = {}

function AuroraCouncilLootOfferFrame:Export()
    local _frame = {}

    local frameBuffer = {};

    function _frame:OpenLootOfferFrame()
        local frame = tremove(frameBuffer)
        if not frame then
            self:CreateRaidResponseFrame();
        else
            self:ResetRaidResponseFrame();
        end
    end

    function _frame:CreateLootOfferFrame()
        CreateFrame("Frame", "AUCO_LootOfferFrame", UIParent);
        AUCO_LootOfferFrame:ClearAllPoints();
    end

    function _frame:ResetLootOfferFrame()
        AUCO_LootOfferFrame:Show();
    end

    function _frame:CloseLootOfferFrame()
        AUCO_LootOfferFrame:Hide()
        tinsert(frameBuffer, AUCO_LootOfferFrame)
    end

    return _frame;
end