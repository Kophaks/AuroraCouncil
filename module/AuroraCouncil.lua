
AuroraCouncil = {};

function AuroraCouncil:New()
    local StateMachine = AuroraCouncilStateMachine:New();
    local Util = AuroraCouncilUtil:New();
    local Message = AuroraCouncilMessage:New(Util);
    local UI = AuroraCouncilUI:New(Util, Message);
    local Config = AuroraCouncilConfiguration:New(Util);

    local _auroraCouncil = {};

    local VERSION_NUMBER = 0.29;
    local VERSION_NAME = "0.3-SNAPSHOT (ALPHA)"
    local VERSION_CHECK_INTERVAL = 15;

    local lootTable;
    local currentItem;
    local isLooting = false;
    local versionCheckLast = 0;

    StaticPopupDialogs["BASIC_LOOT_CONFIRMATION"] = {
        text = "Do you really want to give %s to %s?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function(data)
            GiveMasterLoot(data.itemIndex, data.playerIndex);
            Message:SendItemAssignedInfo(Message.CHANNEL.RAID);
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    Config:SetOnReset(function()
        _auroraCouncil:Reset();
    end)

    function _auroraCouncil:GetChatCommands()
        return Config:GetChatCommands();
    end

    function _auroraCouncil:LootClosed()
        isLooting = false;
    end

    function _auroraCouncil:LootOpened()
        isLooting = true;
        if Util:IsPlayerLootMaster() and StateMachine.current.name == StateMachine.WAITING then
            Message:SendResetRequest(Message.CHANNEL.RAID);
            local itemCount = self:InitializeCouncil();
            UI.LootMasterFrame:ResizeFrame(itemCount);
        end
    end

    function _auroraCouncil:LootMethodChanged()
        self:Reset();
    end

    function _auroraCouncil:PlayerEnteringWorld()
        local versionInfo = Message:CreateVersionInfoRequest(VERSION_NUMBER, VERSION_NAME);
        Message:SendVersionInfoRequest(versionInfo, Message.CHANNEL.RAID)
    end

    function _auroraCouncil:Reset()
        currentItem = nil;
        lootTable = nil;
        StateMachine:Reset();
        UI:Init();
    end

    function _auroraCouncil:Init()
        if Util:IsPlayerLootMaster() then Message:SendResetRequest("RAID") else self:Reset() end
    end

    function _auroraCouncil:ShowStartupMessage()
        Util:Print("Enabled!");
    end

    function _auroraCouncil:InitializeCouncil()
        local numValidItems = 0;
        if self:CheckPreconditions() then
            Message:SendMasterIsLootingInfo(Message.CHANNEL.RAID);
            lootTable = {};
            self.items = {}
            numValidItems = self:FillValidItems(lootTable);
            if numValidItems > 0 then
                Message:SendSessionStartRequest(Message.CHANNEL.RAID);
                for key, value in pairs(lootTable) do
                    local _, itemLink = unpack(value);
                    Message:SendShowItemInfo(itemLink, Message.CHANNEL.RAID);
                    UI.LootMasterFrame:SetItemEntry(key, itemLink);
                end
            else
                Message:NoValidItemsInfo(Message.CHANNEL.RAID);
            end
        end
        return numValidItems;
    end

    function _auroraCouncil:CheckPreconditions()
        return Config:IsEnabled() and Util:IsPlayerLootMaster();
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
        --Util:Debug(prefix .. ": " .. message);
        if      prefix == Message.RESET             then self:Reset()
        elseif  prefix == Message.VERSION           then self:HandleVersionInfoMessage(message)
        elseif  prefix == Message.MASTER_IS_LOOTING then self:HandleMasterIsLootingMessage()
        elseif  prefix == Message.SELECT_ITEM       then self:HandleItemSelectedMessage(message)
        elseif  prefix == Message.NO_ITEMS          then self:HandleNoItemsMessage()
        elseif  prefix == Message.SESSION_START     then self:HandleStartMessage(sender)
        elseif  prefix == Message.SHOW_ITEM         then self:HandleItemMessage(message, sender)
        elseif  prefix == Message.OFFER_ITEM        then self:HandleLootMessage(message)
        elseif  prefix == Message.SELECT_OPTION     then self:HandleSelectOptionMessage(message, sender)
        elseif  prefix == Message.GIVE_ITEM         then self:HandleGiveItemMessage(message, sender)
        elseif  prefix == Message.ITEM_ASSIGNED     then self:HandleItemAssignedMessage()
        elseif  prefix == Message.RESEND_OPTIONS     then self:HandleResendOptionsMessage()
        end
        UI:UpdateState(StateMachine);
    end

    function _auroraCouncil:HandleVersionInfoMessage(message)
        local versionNumber, versionName = Message:SplitVersionInfoMessage(message);
        local hours,minutes = GetGameTime();
        local time = hours*60+minutes;
        if(time < versionCheckLast) then versionCheckLast = time end;
        if(time-VERSION_CHECK_INTERVAL >= versionCheckLast) then
            versionCheckLast = time;
            if(versionNumber > VERSION_NUMBER) then
                Util:Print("Your version is " .. VERSION_NAME .. ". version " .. versionName .. " has been released, please update to the newest version to avoid any problems.")
            end
        end
    end

    function _auroraCouncil:HandleMasterIsLootingMessage()
        StateMachine.current:LootCorpse();
    end

    function _auroraCouncil:HandleItemSelectedMessage(itemLink)
        if Util:IsPlayerLootMaster() then
            currentItem = itemLink;
            local numLootOptions, lootOptions = Config:GetLootOptions();
            local request = Message:CreateOfferItemRequest(itemLink, numLootOptions,
                lootOptions[1], lootOptions[2], lootOptions[3],
                lootOptions[4], lootOptions[5], lootOptions[6])
            Message:SendOfferItemRequest(request, Message.CHANNEL.RAID);
        end
    end

    function _auroraCouncil:HandleNoItemsMessage()
        StateMachine.current:NoLoot();
    end

    function _auroraCouncil:HandleStartMessage(sender)
        if(currentItem == nil) then
            Util:Print("Loot Distribution Started!");
            Util:Print("Loot Master: " .. sender);
        else currentItem = nil;
        end

        StateMachine.current:SomeLoot(sender == (UnitName("player")))
    end

    function _auroraCouncil:HandleItemMessage(itemLink, sender)
        if sender ~= (UnitName("player")) then Util:Print("Item: " .. itemLink) end
    end

    function _auroraCouncil:HandleLootMessage(offerItemRequest)
        if StateMachine.MASTER_LOOTING == StateMachine.current.name or
                StateMachine.AWAIT_ITEM == StateMachine.current.name or
                StateMachine.WAITING == StateMachine.current.name then
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

    function _auroraCouncil:HandleSelectOptionMessage(message, sender)
        if StateMachine.WAITING == StateMachine.current.name then
            StateMachine.current:SomeLoot(false);
            Message:SendResendOptionsRequest(Message.CHANNEL.RAID);
        end
        local option, item = Message:SplitSelectOptionMessage(message);
        UI.RaidResponseFrame:AddPlayerEntry(option, sender, item)
        if sender == (UnitName("player")) then
            StateMachine.current:ChooseOption();
        end
    end

    function _auroraCouncil:HandleGiveItemMessage(targetPlayer, sender)
        if sender == UnitName("player") and Util:IsPlayerLootMaster() then
            if isLooting == false then Util:Print("You need to be looting a Corpse to assign an item") end

            for playerIndex = 1, GetNumRaidMembers() do
                if (GetMasterLootCandidate(playerIndex) == targetPlayer) then
                    self:GiveItemTo(currentItem, playerIndex, targetPlayer);
                    return;
                end
            end
            Util:Print(targetPlayer .. " not eligible for Loot")
        end
    end

    function _auroraCouncil:HandleResendOptionsMessage()
        if Util:IsPlayerLootMaster() then
            local numLootOptions, lootOptions = Config:GetLootOptions();
            local request = Message:CreateOfferItemRequest(currentItem, numLootOptions,
                lootOptions[1], lootOptions[2], lootOptions[3],
                lootOptions[4], lootOptions[5], lootOptions[6])
            Message:SendOfferItemRequest(request, Message.CHANNEL.RAID);
        end
    end

    function _auroraCouncil:GiveItemTo(item, playerIndex, playerName)
        for itemIndex = 1, GetNumLootItems() do
            local itemLink = GetLootSlotLink(itemIndex);
            if itemLink == item then
                local confirmationDialog = StaticPopup_Show("BASIC_LOOT_CONFIRMATION", item, playerName)
                    if (confirmationDialog) then
                        local confirmationData = {}
                        confirmationData.itemIndex = itemIndex;
                        confirmationData.playerIndex = playerIndex;
                        confirmationDialog.data = confirmationData;
                end
                return;
            end
        end
        Util:Print("Item not found ... are you looting the correct corpse?")
    end

    function _auroraCouncil:HandleItemAssignedMessage()
        StateMachine.current:AssignItem();
        self:InitializeCouncil()
    end

    function _auroraCouncil:GetConfig()
        return Config;
    end

    return _auroraCouncil;
end