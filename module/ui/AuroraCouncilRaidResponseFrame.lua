AuroraCouncilRaidResponseFrame = {}

function AuroraCouncilRaidResponseFrame:Export()
    local Util = AuroraCouncilUtil:Export();

    local _frame = {}

    local frameBuffer = {};
    local entryBuffer = {}

    local FRAME_HEIGHT_EXTRA = 12;
    local FRAME_TEXT_OFFSET = 8;
    local PLAYER_ENTRY_COUNT = 40;
    local PLAYER_ENTRY_HEIGHT = 14;
    local PLAYER_STATUS_WIDTH = 60;
    local PLAYER_NAME_WIDTH = 100;
    local PLAYER_ITEM_WIDTH = 200;
    local FRAME_WIDTH = PLAYER_STATUS_WIDTH + PLAYER_NAME_WIDTH
            + PLAYER_ITEM_WIDTH + FRAME_TEXT_OFFSET *2;

    local frameBackground = {
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    }

    function _frame:OpenFrame()
        if (AUCO_RaidResponseFrame ~= nil) then
            self:CloseFrame();
        end
        local frame = tremove(frameBuffer)
        if not frame then
            self:CreateFrame();
            for entry = 1, PLAYER_ENTRY_COUNT do
                self:CreatePlayerEntry(entry);
            end
        else
            self:ResetFrame();
        end
    end

    function _frame:CloseFrame()
        AUCO_RaidResponseFrame:Hide()
        tinsert(frameBuffer, AUCO_RaidResponseFrame)
    end


    function _frame:CreateFrame()
        CreateFrame("Frame", "AUCO_RaidResponseFrame", UIParent);
        AUCO_RaidResponseFrame:ClearAllPoints();
        AUCO_RaidResponseFrame:SetWidth(FRAME_WIDTH);
        AUCO_RaidResponseFrame:SetHeight(PLAYER_ENTRY_COUNT * PLAYER_ENTRY_HEIGHT + FRAME_HEIGHT_EXTRA);
        AUCO_RaidResponseFrame:SetPoint("TOP", 320, 0);
        AUCO_RaidResponseFrame:SetMovable(true);
        AUCO_RaidResponseFrame:SetBackdrop(frameBackground);
        AUCO_RaidResponseFrame:SetBackdropColor(0.1, 0.1, 0.5, 0.5);
        AUCO_RaidResponseFrame:EnableMouse(true);
        AUCO_RaidResponseFrame:SetClampedToScreen(true);
        AUCO_RaidResponseFrame:RegisterForDrag("LeftButton");
        AUCO_RaidResponseFrame:SetFrameLevel(3);
        AUCO_RaidResponseFrame:Show();
        AUCO_RaidResponseFrame:SetScript("OnDragStart", function()
            this:StartMoving();
            this.isMoving = true;
        end)
        AUCO_RaidResponseFrame:SetScript("OnDragStop", function()
            this:StopMovingOrSizing();
            this.isMoving = false;
        end)
    end

    function _frame:ResetFrame()
        AUCO_RaidResponseFrame:Show();
    end

    function _frame:CreatePlayerEntry(entryId)
        local itemLinkFrame = CreateFrame("Button", "AUCO_PlayerEntry" .. entryId, AUCO_RaidResponseFrame);
        local curPos = (entryId * -PLAYER_ENTRY_HEIGHT) + PLAYER_ENTRY_HEIGHT - 5
        itemLinkFrame:SetWidth(FRAME_WIDTH - FRAME_TEXT_OFFSET *2);
        itemLinkFrame:SetHeight(PLAYER_ENTRY_HEIGHT);
        itemLinkFrame:SetBackdropColor(0,0,0,1);
        itemLinkFrame:SetPoint("TOP", 0, curPos);
        itemLinkFrame.status = itemLinkFrame:CreateFontString("AUCO_RaidResponseFrameStatus" .. entryId, "OVERLAY", "GameFontNormalSmall");
        itemLinkFrame.status:SetText("Need");
        itemLinkFrame.status:SetWidth(PLAYER_STATUS_WIDTH)
        itemLinkFrame.status:SetPoint("LEFT", 0, 0);
        itemLinkFrame.status:SetJustifyH("LEFT");
        itemLinkFrame.player = itemLinkFrame:CreateFontString("AUCO_RaidResponseFramePlayer" .. entryId, "OVERLAY", "GameFontNormalSmall");
        itemLinkFrame.player:SetText("player" .. entryId);
        itemLinkFrame.player:SetWidth(PLAYER_NAME_WIDTH)
        itemLinkFrame.player:SetPoint("LEFT",PLAYER_STATUS_WIDTH,0);
        itemLinkFrame.player:SetJustifyH("CENTER");
        itemLinkFrame.item = itemLinkFrame:CreateFontString("AUCO_RaidResponseFrameItem" .. entryId, "OVERLAY", "GameFontNormalSmall");
        itemLinkFrame.item:SetText(GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")));
        itemLinkFrame.item:SetWidth(PLAYER_ITEM_WIDTH)
        itemLinkFrame.item:SetPoint("LEFT",PLAYER_STATUS_WIDTH+PLAYER_NAME_WIDTH,0);
        itemLinkFrame.item:SetJustifyH("LEFT");
        itemLinkFrame:SetScript("OnEnter", function()
            local text = this.item:GetText();
            if text ~= nil then
                local itemId = Util:GetItemId(text);
                GameTooltip:SetOwner(this, "ANCHOR_RIGHT", FRAME_TEXT_OFFSET);
                GameTooltip:SetHyperlink(itemId);
                GameTooltip:Show();
            end
        end)
        itemLinkFrame:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        entryBuffer[entryId] = itemLinkFrame;
    end


    return _frame;
end