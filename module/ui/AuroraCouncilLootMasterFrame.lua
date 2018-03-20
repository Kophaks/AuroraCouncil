AuroraCouncilLootMasterFrame = {};

function AuroraCouncilLootMasterFrame:Export()
    local Util = AuroraCouncilUtil:Export();
    local Message = AuroraCouncilMessage:Export();

    local _frame = {}

    local frameBuffer = {};
    local entryBuffer = {};

    local ITEM_ENTRY_COUNT = 16;
    local ITEM_ENTRY_HEIGHT = 26;
    local FRAME_WIDTH = 250;
    local FRAME_HEIGHT_EXTRA = 70;
    local FRAME_TITLE = "Aurora LootCouncil";

    local itemBackground = {
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    }

    local frameBackground = {
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    }

    function _frame:OpenFrame()
        local frame = tremove(frameBuffer)
        if not frame then
            self:CreateFrame();
            for entry = 1, ITEM_ENTRY_COUNT do
                self:CreateItemEntry(entry);
            end
        else
            self:ResetFrame();
        end
    end

    function _frame:CloseFrame()
        AUCO_CouncilFrame:Hide()
        tinsert(frameBuffer, AUCO_CouncilFrame)
    end

    function _frame:ResizeFrame(itemCount)
        AUCO_CouncilFrame:SetHeight((itemCount * ITEM_ENTRY_HEIGHT) + FRAME_HEIGHT_EXTRA);
    end

    function _frame:SetItemEntry(position, itemLink)
        local itemLinkFrame = entryBuffer[position];
        itemLinkFrame:SetBackdrop(itemBackground);
        itemLinkFrame:SetBackdropColor(0,0,0,1);
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

    function _frame:CreateFrame()
        CreateFrame("Frame", "AUCO_CouncilFrame", UIParent);
        AUCO_CouncilFrame:ClearAllPoints();
        AUCO_CouncilFrame:SetWidth(FRAME_WIDTH);
        AUCO_CouncilFrame:SetHeight(FRAME_HEIGHT_EXTRA);
        AUCO_CouncilFrame:SetPoint("TOP", -310, 0);
        AUCO_CouncilFrame:SetMovable(true);
        AUCO_CouncilFrame:SetBackdrop(frameBackground);
        AUCO_CouncilFrame:SetBackdropColor(0.1, 0.1, 0.5, 0.5);
        AUCO_CouncilFrame:EnableMouse(true);
        AUCO_CouncilFrame:SetClampedToScreen(true);
        AUCO_CouncilFrame:RegisterForDrag("LeftButton");
        AUCO_CouncilFrame.title = AUCO_CouncilFrame:CreateFontString("AUCO_CouncilFrame_Title", "OVERLAY", "GameFontNormal");
        AUCO_CouncilFrame.title:SetPoint("TOP", 0, -ITEM_ENTRY_HEIGHT);
        AUCO_CouncilFrame.title:SetText(FRAME_TITLE);
        AUCO_CouncilFrame:SetFrameLevel(3);
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

    function _frame:ResetFrame()
        for entry = 1, ITEM_ENTRY_COUNT do
            self:ResetItemEntry(entry);
        end
        AUCO_CouncilFrame:Show();
    end

    function _frame:CreateItemEntry(entryId)
        local itemLinkFrame = CreateFrame("Button", "AUCO_ItemLink" .. entryId, AUCO_CouncilFrame);
        local curPos = (entryId * -ITEM_ENTRY_HEIGHT) - 30
        itemLinkFrame:SetWidth(FRAME_WIDTH -10);
        itemLinkFrame:SetHeight(ITEM_ENTRY_HEIGHT);
        itemLinkFrame:SetBackdrop(nil);
        itemLinkFrame:SetPoint("TOP", 0, curPos);
        itemLinkFrame.text = itemLinkFrame:CreateFontString("AUCO_CouncilFrameItem" .. entryId, "OVERLAY", "GameFontNormalSmall");
        itemLinkFrame.text:SetText(nil);
        itemLinkFrame.text:SetPoint("CENTER", 0, 0);
        entryBuffer[entryId] = itemLinkFrame;
    end

    function _frame:ResetItemEntry(entryId)
        local itemLinkFrame = entryBuffer[entryId];
        itemLinkFrame.text:SetText(nil);
        itemLinkFrame:SetBackdrop(nil);
    end


    return _frame;
end