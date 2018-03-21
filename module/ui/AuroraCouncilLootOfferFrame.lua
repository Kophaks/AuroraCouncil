AuroraCouncilLootOfferFrame = {}

function AuroraCouncilLootOfferFrame:Export()
    local Util = AuroraCouncilUtil:Export();

    local _frame = {};

    local frameBuffer = {};

    local ITEM_ENTRY_HEIGHT = 26;
    local FRAME_WIDTH = 250;
    local FRAME_HEIGHT_EXTRA = 70;

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
            self:CreateButtons();
        else
            self:ResetFrame();
        end
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

    function _frame:CreateButtons()
        CreateFrame("Button", "AUCO_OfferButton1", AUCO_LootOfferFrame);
        local curPos = -ITEM_ENTRY_HEIGHT - 30;
        AUCO_OfferButton1:SetWidth(FRAME_WIDTH -10);
        AUCO_OfferButton1:SetHeight(ITEM_ENTRY_HEIGHT);
        AUCO_OfferButton1:SetBackdrop(itemBackground);
        AUCO_OfferButton1:SetBackdropColor(0,0,0,1);
        AUCO_OfferButton1:SetPoint("TOP", 0, curPos);
        AUCO_OfferButton1.text = AUCO_OfferButton1:CreateFontString("AUCO_OfferButton1Text", "OVERLAY", "GameFontNormalSmall");
        AUCO_OfferButton1.text:SetText("BiS");
        AUCO_OfferButton1.text:SetPoint("CENTER", 0, 0);

        CreateFrame("Button", "AUCO_OfferButton2", AUCO_LootOfferFrame);
        curPos = curPos - ITEM_ENTRY_HEIGHT;
        AUCO_OfferButton2:SetWidth(FRAME_WIDTH -10);
        AUCO_OfferButton2:SetHeight(ITEM_ENTRY_HEIGHT);
        AUCO_OfferButton2:SetBackdrop(itemBackground);
        AUCO_OfferButton2:SetBackdropColor(0,0,0,1);
        AUCO_OfferButton2:SetPoint("TOP", 0, curPos);
        AUCO_OfferButton2.text = AUCO_OfferButton2:CreateFontString("AUCO_OfferButton2Text", "OVERLAY", "GameFontNormalSmall");
        AUCO_OfferButton2.text:SetText("Need");
        AUCO_OfferButton2.text:SetPoint("CENTER", 0, 0);

        CreateFrame("Button", "AUCO_OfferButton3", AUCO_LootOfferFrame);
        curPos = curPos - ITEM_ENTRY_HEIGHT;
        AUCO_OfferButton3:SetWidth(FRAME_WIDTH -10);
        AUCO_OfferButton3:SetHeight(ITEM_ENTRY_HEIGHT);
        AUCO_OfferButton3:SetBackdrop(itemBackground);
        AUCO_OfferButton3:SetBackdropColor(0,0,0,1);
        AUCO_OfferButton3:SetPoint("TOP", 0, curPos);
        AUCO_OfferButton3.text = AUCO_OfferButton3:CreateFontString("AUCO_OfferButton3Text", "OVERLAY", "GameFontNormalSmall");
        AUCO_OfferButton3.text:SetText("Offspec");
        AUCO_OfferButton3.text:SetPoint("CENTER", 0, 0);

        CreateFrame("Button", "AUCO_OfferButton4", AUCO_LootOfferFrame);
        curPos = curPos - ITEM_ENTRY_HEIGHT;
        AUCO_OfferButton4:SetWidth(FRAME_WIDTH -10);
        AUCO_OfferButton4:SetHeight(ITEM_ENTRY_HEIGHT);
        AUCO_OfferButton4:SetBackdrop(itemBackground);
        AUCO_OfferButton4:SetBackdropColor(0,0,0,1);
        AUCO_OfferButton4:SetPoint("TOP", 0, curPos);
        AUCO_OfferButton4.text = AUCO_OfferButton4:CreateFontString("AUCO_OfferButton4Text", "OVERLAY", "GameFontNormalSmall");
        AUCO_OfferButton4.text:SetText("Pass");
        AUCO_OfferButton4.text:SetPoint("CENTER", 0, 0);
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