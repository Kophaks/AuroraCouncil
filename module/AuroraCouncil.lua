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

    function _auroraCouncil:Enable(isEnabled)
        if isEnabled then
            Util:Print("enabled!");
        else
            Util:Print("disabled!");
        end
        enabled = isEnabled;
        Message:SendResetRequest("RAID");
    end

    function _auroraCouncil:LootOpened()
        if enabled and StateMachine.current.name == StateMachine.WATING then
            Message:SendResetRequest("RAID");
            local itemCount = self:InitializeCouncil();
            UI.LootMasterFrame:ResizeFrame(itemCount);
        end
    end

    function _auroraCouncil:Init()
        enabled = true;
        UI:Init();
    end

    function _auroraCouncil:ChatMsgAddon(prefix, message, sender)
        if prefix == Message.RESET then
            self:HandleResetMessage();
        end
        if enabled then
            if prefix == Message.MASTER_IS_LOOTING then
                self:HandleMasterIsLooting();
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
    end

    function _auroraCouncil:InitializeCouncil()
        local numValidItems = 0;
        if self:CheckPreconditions() then
            Message:SendMasterIsLootingInfo("Raid");
            lootTable = {};
            numValidItems = self:GetValidItems();
            if numValidItems > 0 then
                Message:SendSessionStartRequest("Raid");
            else
                Message:NoValidItemsInfo("Raid");
            end
            self.items = {}

            for key, value in pairs(lootTable) do
                local _, itemLink = unpack(value);
                Message:SendShowItemInfo(itemLink, "RAID");
                UI.LootMasterFrame:SetItemEntry(key, itemLink);
            end
        end
        return numValidItems;
    end

function _auroraCouncil:GetValidItems()
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

    function _auroraCouncil:HandleLootMessage(offerItemRequest)
        if StateMachine.MASTER_LOOTING == StateMachine.current.name or StateMachine.AWAIT_ITEM == StateMachine.current.name then
            local itemLink, option1, option2, option3, option4, option5 = Message:SplitOfferItemRequest(offerItemRequest);
            currentItem = itemLink;
            UI.LootOfferFrame:SetItem(itemLink);
            UI.LootOfferFrame:AddOption(option1);
            UI.LootOfferFrame:AddOption(option2);
            UI.LootOfferFrame:AddOption(option3);
            UI.LootOfferFrame:AddOption(option4);
            UI.LootOfferFrame:AddOption(option5);
            UI.LootOfferFrame:ResizeFrame();
            StateMachine.current:ChooseItem();
        end
    end

    function _auroraCouncil:ShowStartupMessage()
        Util:Print("Enabled!");
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
        for playerIndex = 1, GetNumRaidMembers() do
            if (GetMasterLootCandidate(playerIndex) == targetPlayer) then
                self:GiveItemTo(currentItem, playerIndex);
            end
        end
    end

    function _auroraCouncil:GiveItemTo(item, player)
        for itemIndex = 1, GetNumLootItems() do
            local itemLink = GetLootSlotLink(itemIndex);

            if itemLink == item then
                GiveMasterLoot(itemIndex, player);
                Message:SendItemAssignedInfo("Raid");
            end
        end
    end

    function _auroraCouncil:HandleResetMessage()
        StateMachine:Reset();
        UI:Init();
        currentItem = nil;
        lootTable = nil;
    end

    function _auroraCouncil:SelectOption(message, sender)
        local option, item = Message:SplitSelectOptionMessage(message);
        UI.RaidResponseFrame:AddPlayerEntry(option, sender, item)
        if sender == (UnitName("player")) then
            StateMachine.current:ChooseOption();
        end
    end

    function _auroraCouncil:CheckPreconditions()
        return Util:IsPlayerLootMaster();
    end


    return _auroraCouncil;
end

