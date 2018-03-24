local Util = AuroraCouncilUtil:Export();
local Message = AuroraCouncilMessage:Export();

AuroraCouncilLootOfferFrame = {}

function AuroraCouncilLootOfferFrame:Export()
    local _frame = {};

    local frameBuffer = {};
    local optionsBuffer = {};

    local ITEM_ENTRY_HEIGHT = 26;
    local FRAME_WIDTH = 250;
    local FRAME_HEIGHT_EXTRA = 70;

    local NUM_BUTTONS = 5;

    local optionBackground = {
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
    local nextOption = 1;

    function _frame:OpenFrame()
        nextOption = 1;
        if (AUCO_LootOfferFrame ~= nil) then
            self:CloseFrame();
        end
        local frame = tremove(frameBuffer)
        if not frame then
            self:CreateFrame();
            self:CreateButtons();
        else
            self:ResetFrame();
            self:ResetButtons();
        end
        self:ResizeFrame(0);
    end

    function _frame:CreateFrame()
        CreateFrame("Frame", "AUCO_LootOfferFrame", UIParent);
        AUCO_LootOfferFrame:ClearAllPoints();
        AUCO_LootOfferFrame:SetWidth(FRAME_WIDTH);
        AUCO_LootOfferFrame:SetHeight((4 * ITEM_ENTRY_HEIGHT) + FRAME_HEIGHT_EXTRA);
        AUCO_LootOfferFrame:SetPoint("CENTER", 0, 0);
        AUCO_LootOfferFrame:SetMovable(true);
        AUCO_LootOfferFrame:SetBackdrop(frameBackground);
        AUCO_LootOfferFrame:SetBackdropColor(0.1, 0.1, 0.5, 0.5);
        AUCO_LootOfferFrame:EnableMouse(true);
        AUCO_LootOfferFrame:SetClampedToScreen(true);
        AUCO_LootOfferFrame:RegisterForDrag("LeftButton");
        AUCO_LootOfferFrame:SetFrameLevel(4);
        CreateFrame("Button", "AUCO_LootOfferTitleFrame", AUCO_LootOfferFrame);
        AUCO_LootOfferTitleFrame:SetWidth(FRAME_WIDTH -10);
        AUCO_LootOfferTitleFrame:SetHeight(ITEM_ENTRY_HEIGHT);
        AUCO_LootOfferTitleFrame:SetBackdropColor(0,0,0,1);
        AUCO_LootOfferTitleFrame:SetPoint("TOP", 0, -ITEM_ENTRY_HEIGHT)
        AUCO_LootOfferTitleFrame.title = AUCO_LootOfferTitleFrame:CreateFontString("AUCO_LootOfferTitleFrame", "OVERLAY", "GameFontNormal");
        AUCO_LootOfferTitleFrame.title:SetPoint("CENTER", 0, 0);
        AUCO_LootOfferTitleFrame.title:SetText("TEST");
        AUCO_LootOfferFrame:Show();
        AUCO_LootOfferFrame:SetScript("OnDragStart", function()
            this:StartMoving();
            this.isMoving = true;
        end)
        AUCO_LootOfferFrame:SetScript("OnDragStop", function()
            this:StopMovingOrSizing();
            this.isMoving = false;
        end)
    end

    function _frame:ResizeFrame(options)
        AUCO_LootOfferFrame:SetHeight(options * ITEM_ENTRY_HEIGHT + FRAME_HEIGHT_EXTRA);
    end

    function _frame:AddOption(optionName)
        local optionFrame = optionsBuffer[nextOption];
        optionFrame.text:SetText(optionName);
        optionFrame:SetBackdrop(optionBackground);
        optionFrame:SetBackdropColor(0,0,0,1);
        self:ResizeFrame(nextOption)
        optionFrame:SetScript("OnClick", function()
            local text = this.text:GetText();
            if text ~= nil then
                Message:SendSelectOptionRequest(text, GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"), "RAID"));
            end
        end)
        nextOption = nextOption + 1;
    end

    function _frame:CreateButtons()
        for buttonId = 1, NUM_BUTTONS do
            self:CreateButton(buttonId);
        end
    end

    function _frame:CreateButton(buttonId)
        local optionFrame = CreateFrame("Button", "AUCO_OfferButton" .. buttonId, AUCO_LootOfferFrame);
        local curPos = buttonId * -ITEM_ENTRY_HEIGHT - 30;
        optionFrame:SetWidth(FRAME_WIDTH -10);
        optionFrame:SetHeight(ITEM_ENTRY_HEIGHT);
        optionFrame:SetBackdrop(nil);
        optionFrame:SetBackdropColor(0,0,0,1);
        optionFrame:SetPoint("TOP", 0, curPos);
        optionFrame.text = optionFrame:CreateFontString("AUCO_OfferButton1Text", "OVERLAY", "GameFontNormalSmall");
        optionFrame.text:SetText(nil);
        optionFrame.text:SetPoint("CENTER", 0, 0);
        optionsBuffer[buttonId] = optionFrame;
    end

    function _frame:ResetButtons()
        for buttonId = 1, NUM_BUTTONS do
            local optionFrame = optionsBuffer[buttonId];
            optionFrame.text:SetText(nil);
            optionFrame:SetBackdrop(nil);
        end
    end

    function _frame:ResetFrame()
        AUCO_LootOfferTitleFrame.title:SetText(nil);
        AUCO_LootOfferFrame:Show();
    end

    function _frame:CloseFrame()
        AUCO_LootOfferFrame:Hide()
        tinsert(frameBuffer, AUCO_LootOfferFrame)
    end

    function _frame:SetItem(itemLink)
        AUCO_LootOfferTitleFrame.title:SetText(itemLink);
        AUCO_LootOfferTitleFrame:SetScript("OnEnter", function()
            if itemLink ~= nil then
                local itemId = Util:GetItemId(itemLink);
                GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
                GameTooltip:SetHyperlink(itemId);
                GameTooltip:Show();
            end
        end)
        AUCO_LootOfferTitleFrame:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    end

    return _frame;
end