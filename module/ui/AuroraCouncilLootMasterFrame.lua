AuroraCouncilLootMasterFrame = {};

function AuroraCouncilLootMasterFrame:Export()
    local Util = AuroraCouncilUtil:Export();
    local Message = AuroraCouncilMessage:Export();

    local _frame = {}

    -- PRIVATE
    local lootCouncilFrame = {};
    local lootCouncilItemEntries = {};

    local ITEM_ENTRY_COUNT = 16;
    local ITEM_ENTRY_HEIGHT = 16;
    local LOOT_COUNCIL_FRAME_WIDTH = 200;
    local LOOT_COUNCIL_FRAME_HEIGHT_EXTRA = 70;
    local LOOT_COUNCIL_FRAME_TITLE = "Aurora LootCouncil";

    -- PRIVATE END





    function _frame:OpenLootMasterFrame()
        local frame = tremove(lootCouncilFrame)
        if not frame then
            self:CreateLootMasterFrame();
            for entry = 1, ITEM_ENTRY_COUNT do
                self:CreateItemEntry(entry);
            end
        else
            self:ResetLootMasterFrame();
        end
    end

    function _frame:CreateLootMasterFrame()
        CreateFrame("Frame", "AUCO_CouncilFrame", UIParent);
        AUCO_CouncilFrame:ClearAllPoints();
        AUCO_CouncilFrame:SetWidth(LOOT_COUNCIL_FRAME_WIDTH);
        AUCO_CouncilFrame:SetHeight(LOOT_COUNCIL_FRAME_HEIGHT_EXTRA);
        AUCO_CouncilFrame:SetPoint("CENTER", 0, 0);
        AUCO_CouncilFrame:SetMovable(true);
        AUCO_CouncilFrame:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        AUCO_CouncilFrame:SetBackdropColor(0, 0, 0, 1);
        AUCO_CouncilFrame:EnableMouse(true);
        AUCO_CouncilFrame:SetClampedToScreen(true);
        AUCO_CouncilFrame:RegisterForDrag("LeftButton");
        AUCO_CouncilFrame.title = AUCO_CouncilFrame:CreateFontString("AUCO_CouncilFrame_Title", "OVERLAY", "GameFontNormal");
        AUCO_CouncilFrame.title:SetPoint("TOPLEFT", 20, -ITEM_ENTRY_HEIGHT);
        AUCO_CouncilFrame.title:SetText(LOOT_COUNCIL_FRAME_TITLE);
        AUCO_CouncilFrame:Show();
        AUCO_CouncilFrame:SetScript("OnDragStart", function()
            this:StartMoving();
            this.isMoving = true;
        end)
        AUCO_CouncilFrame:SetScript("OnDragStop", function()
            this:StopMovingOrSizing();
            this.isMoving = false;
        end)
    end

    function _frame:ResetLootMasterFrame()
        for entry = 1, ITEM_ENTRY_COUNT do
            self:ResetItemEntry(entry);
        end
        AUCO_CouncilFrame:Show();
    end

    function _frame:CloseLootMasterFrame()
        AUCO_CouncilFrame:Hide()
        tinsert(lootCouncilFrame, AUCO_CouncilFrame)
    end

    function _frame:ResizeLootMasterFrame(itemCount)
        AUCO_CouncilFrame:SetHeight((itemCount * ITEM_ENTRY_HEIGHT) + LOOT_COUNCIL_FRAME_HEIGHT_EXTRA);
    end

    function _frame:CreateItemEntry(entryId)
        local itemLinkFrame = CreateFrame("Button", "AUCO_ItemLink" .. entryId, AUCO_CouncilFrame);
        local curPos = (entryId*-20)-30
        itemLinkFrame:SetWidth(LOOT_COUNCIL_FRAME_WIDTH);
        itemLinkFrame:SetHeight(ITEM_ENTRY_HEIGHT);
        itemLinkFrame:SetPoint("TOPLEFT", ITEM_ENTRY_HEIGHT, curPos);
        itemLinkFrame.text = itemLinkFrame:CreateFontString("AUCO_CouncilFrameItem" .. entryId, "OVERLAY", "GameFontNormal");
        itemLinkFrame.text:SetText(nil);
        itemLinkFrame.text:SetPoint("LEFT", 0, 0);
        lootCouncilItemEntries[entryId] = itemLinkFrame;
    end

    function _frame:ResetItemEntry(entryId)
        local itemLinkFrame = lootCouncilItemEntries[entryId];
        itemLinkFrame.text:SetText(nil);
    end

    function _frame:SetItemEntry(position, itemLink)
        local itemLinkFrame = lootCouncilItemEntries[position];
        itemLinkFrame:SetScript("OnClick", function()
            local text = this.text:GetText();
            if text ~= nil then
                Message:SendOfferItemRequest(itemLink, "RAID");
            end
        end)
        itemLinkFrame:SetScript("OnEnter", function()
            local text = this.text:GetText();
            if text ~= nil then
                local itemId = Util:GetItemId(text);
                GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
                GameTooltip:SetHyperlink(itemId);
                GameTooltip:Show();
            end
        end)
        itemLinkFrame:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        itemLinkFrame.text:SetText(itemLink);
    end

    -- PUBLIC END


    return _frame;
end