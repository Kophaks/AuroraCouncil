local UI = AuroraCouncilUI:Export();
local Message = AuroraCouncilMessage:Export();
local Util = AuroraCouncilUtil:Export();
local StateMachine = AuroraCouncilStateMachine:Export();

AuroraCouncil = {};

function AuroraCouncil:Export()
    local _auroraCouncil = {};

    local lootTable;
    local currentItem;
    local enabled;
    local isLooting = false;

    local numLootOptions = 3;
    local lootOptions = {};
    lootOptions[1] = {};
    lootOptions[1].visible = true;
    lootOptions[1].text = "Need";
    lootOptions[2] = {};
    lootOptions[2].visible = true;
    lootOptions[2].text = "Greed";
    lootOptions[3] = {};
    lootOptions[3].visible = true;
    lootOptions[3].text = "Pass";
    lootOptions[4] = {};
    lootOptions[4].visible = true;
    lootOptions[4].text = "option4";
    lootOptions[5] = {};
    lootOptions[5].visible = true;
    lootOptions[5].text = "option5";
    lootOptions[6] = {};
    lootOptions[6].visible = true;
    lootOptions[6].text = "option6";

    function _auroraCouncil:Enable(isEnabled)
        enabled = isEnabled;
    end

    function _auroraCouncil:IsEnabled()
        return enabled;
    end

    function _auroraCouncil:SetEnabledOptionsCount(count)
        numLootOptions = count;
    end

    function _auroraCouncil:GetEnabledOptionsCount()
        return numLootOptions;
    end

    function _auroraCouncil:SetOptionVisible(optionNum, visible)
        lootOptions[optionNum].visible = visible;
    end

    function _auroraCouncil:IsOptionVisible(optionNum)
        return lootOptions[optionNum].visible;
    end

    function _auroraCouncil:SetOptionText(optionNum, optionText)
        lootOptions[optionNum].text = string.gsub(optionText, ";", ",");
    end

    function _auroraCouncil:GetOptionText(optionNum)
        return lootOptions[optionNum].text;
    end

    function _auroraCouncil:LootClosed()
        isLooting = false;
    end

    function _auroraCouncil:LootOpened()
        isLooting = true;
        if StateMachine.current.name == StateMachine.WATING then
            Message:SendResetRequest("RAID");
            local itemCount = self:InitializeCouncil();
            UI.LootMasterFrame:ResizeFrame(itemCount);
        end
    end

    function _auroraCouncil:Reset()
        currentItem = nil;
        lootTable = nil;
        StateMachine:Reset();
        UI:Init();
    end

    function _auroraCouncil:Init()
        enabled = true;
        if Util:IsPlayerLootMaster() then
            Message:SendResetRequest("RAID");
        else
            self:Reset();
        end
    end

    function _auroraCouncil:ShowStartupMessage()
        Util:Print("Enabled!");
    end

    function _auroraCouncil:InitializeCouncil()
        local numValidItems = 0;
        if self:CheckPreconditions() then
            Message:SendMasterIsLootingInfo("Raid");
            lootTable = {};
            self.items = {}
            numValidItems = self:FillValidItems(lootTable);
            if numValidItems > 0 then
                Message:SendSessionStartRequest("Raid");
                for key, value in pairs(lootTable) do
                    local _, itemLink = unpack(value);
                    Message:SendShowItemInfo(itemLink, "RAID");
                    UI.LootMasterFrame:SetItemEntry(key, itemLink);
                end
            else
                Message:NoValidItemsInfo("Raid");
            end
        end
        return numValidItems;
    end

    function _auroraCouncil:CheckPreconditions()
        return enabled and Util:IsPlayerLootMaster();
    end

    function _auroraCouncil:FillValidItems(lootTable)
        local numValidItems = 0
        local threshold = GetLootThreshold();
        for itemIndex = 1, GetNumLootItems() do
            local _, _, _, rarity, _, _, _, _ = GetLootSlotInfo(itemIndex);
            if LootSlotIsItem(itemIndex) and rarity >= threshold then
                numValidItems = numValidItems + 1;
                local itemLink = GetLootSlotLink(itemIndex);
                lootTable[numValidItems] = { itemIndex, itemLink };
            end
        end
        return numValidItems;
    end

    function _auroraCouncil:ChatMsgAddon(prefix, message, sender)
        if prefix == Message.RESET then
            self:Reset();
        end
        if prefix == Message.MASTER_IS_LOOTING then
            self:HandleMasterIsLooting();
        end
        if prefix == Message.SELECT_ITEM then
            self:HandleItemSelectedMessage(message);
        end
        if prefix == Message.NO_ITEMS then
            self:HandleNoItems();
        end
        if prefix == Message.SESSION_START then
            self:HandleStartMessage(sender);
        end
        if prefix == Message.SHOW_ITEM then
            self:HandleItemMessage(message, sender);
        end
        if prefix == Message.OFFER_ITEM then
            self:HandleLootMessage(message);
        end
        if prefix == Message.SELECT_OPTION then
            self:SelectOption(message, sender)
        end
        if prefix == Message.GIVE_ITEM then
            self:HandleGiveItem(message, sender)
        end
        if prefix == Message.ITEM_ASSIGNED then
            self:HandleItemAssigned()
        end
        UI:UpdateState(StateMachine);
    end

    function _auroraCouncil:HandleStartMessage(sender)
        if(currentItem == nil) then
            Util:Print("Loot Distribution Started!");
            Util:Print("Loot Master: " .. sender);
        else
            currentItem = nil;
        end

        if sender == (UnitName("player")) then
            StateMachine.current:SomeLoot(true);
        else
            StateMachine.current:SomeLoot(false)
        end

    end

    function _auroraCouncil:HandleItemMessage(itemLink, sender)
        if sender ~= (UnitName("player")) then
            Util:Print("Item: " .. itemLink);
        end
    end

    function _auroraCouncil:HandleItemSelectedMessage(itemLink)
        if Util:IsPlayerLootMaster() then
            local request = Message:CreateOfferItemRequest(itemLink, numLootOptions,
                lootOptions[1], lootOptions[2], lootOptions[3],
                lootOptions[4], lootOptions[5], lootOptions[6])
            Message:SendOfferItemRequest(request, "RAID");
        end
    end

    function _auroraCouncil:HandleLootMessage(offerItemRequest)
        if StateMachine.MASTER_LOOTING == StateMachine.current.name or StateMachine.AWAIT_ITEM == StateMachine.current.name then
            local itemLink, numOptions, option1, option2, option3, option4, option5, option6 = Message:SplitOfferItemRequest(offerItemRequest);
            local options = {[1] = option1, [2] = option2, [3] = option3, [4] = option4, [5] = option5, [6] = option6}
            currentItem = itemLink;
            UI.LootOfferFrame:SetItem(itemLink);
            for optionIndex = 1, numOptions do
                UI.LootOfferFrame:AddOption(options[optionIndex]);
            end
            UI.LootOfferFrame:ResizeFrame();
            StateMachine.current:ChooseItem();
        end
    end

    function _auroraCouncil:HandleMasterIsLooting()
        StateMachine.current:LootCorpse();
    end

    function _auroraCouncil:HandleNoItems()
        StateMachine.current:NoLoot();
    end

    function _auroraCouncil:HandleItemAssigned()
        StateMachine.current:AssignItem();
        self:InitializeCouncil()
    end

    function _auroraCouncil:HandleGiveItem(targetPlayer, sender)
        if sender == UnitName("player") and Util:IsPlayerLootMaster() then
            if isLooting == false then
                Util:Print("You need to be looting a Corpse to assign an item")
            end

            for playerIndex = 1, GetNumRaidMembers() do
                if (GetMasterLootCandidate(playerIndex) == targetPlayer) then
                    self:GiveItemTo(currentItem, playerIndex);
                    return;
                end
            end
            Util:Print(targetPlayer .. " not eligible for Loot")
        end
    end

    function _auroraCouncil:GiveItemTo(item, player)
        for itemIndex = 1, GetNumLootItems() do
            local itemLink = GetLootSlotLink(itemIndex);

            if itemLink == item then
                GiveMasterLoot(itemIndex, player);
                Message:SendItemAssignedInfo("Raid");
                return;
            end
        end
        Util:Print("Item not found ... are you looting the correct corpse?")
    end

    function _auroraCouncil:SelectOption(message, sender)
        local option, item = Message:SplitSelectOptionMessage(message);
        UI.RaidResponseFrame:AddPlayerEntry(option, sender, item)
        if sender == (UnitName("player")) then
            StateMachine.current:ChooseOption();
        end
    end

    return _auroraCouncil;
end