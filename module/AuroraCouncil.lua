local UI = AuroraCouncilUI:Export();
local Message = AuroraCouncilMessage:Export();
local Util = AuroraCouncilUtil:Export();
local StateMachine = AuroraCouncilStateMachine:Export();

AuroraCouncil = {};

function AuroraCouncil:Export()
    local _auroraCouncil = {};
    local lootTable;

    function _auroraCouncil:LootOpened()
        UI.LootMasterFrame:OpenFrame();
        UI.RaidResponseFrame:OpenFrame();
        local itemCount = self:InitializeCouncil();
        UI.LootMasterFrame:ResizeFrame(itemCount);
        UI.LootOfferFrame:OpenFrame();
        UI.LootOfferFrame:CloseFrame();
    end

    function _auroraCouncil:LootClosed()
        UI.LootMasterFrame:CloseFrame();
        UI.RaidResponseFrame:CloseFrame();
        UI.LootOfferFrame:CloseFrame();
    end

    function _auroraCouncil:init()
        StateMachine.current:LootItem();
        StateMachine.current:SomeLoot(true);
        StateMachine.current:ChooseItem();
        StateMachine.current:ChooseOption();
        StateMachine.current:AssignItem();
        StateMachine.current:SomeLoot(false);
        StateMachine.current:ReceiveOptions();
        StateMachine.current:ChooseOption();
        StateMachine.current:AssignItem();
        StateMachine.current:NoLoot();
    end

    function _auroraCouncil:ChatMsgAddon(prefix, message, sender)
        if sender ~= (UnitName("player")) then
            if prefix == Message.SESSION_START then
                self:HandleStartMessage();
            end
            if prefix == Message.SHOW_ITEM then
                self:HandleItemMessage(message);
            end
        end
        if prefix == Message.OFFER_ITEM then
            self:HandleLootMessage(message);
        end
        if prefix == Message.ADD_OPTION then
            self:AddLootOption(message);
        end
        if prefix == Message.SELECT_OPTION then
            self:SelectOption(message, sender)
        end
    end

    function _auroraCouncil:InitializeCouncil()
        lootTable = {};
        local numLoots = GetNumLootItems();
        local numItems = 0;
        if numLoots > 0 then
            Message:SendSessionStartRequest("Raid")
        end
        self.items = {}
        for itemIndex = 1, GetNumLootItems(), 1 do
            if LootSlotIsItem(itemIndex) then
                numItems = numItems + 1;
                local itemLink = GetLootSlotLink(itemIndex);
                lootTable[numItems] = { itemIndex, itemLink };
            end
        end
        for key, value in pairs(lootTable) do
            local _, itemLink = unpack(value);
            Message:SendShowItemInfo(itemLink, "RAID");
            UI.LootMasterFrame:SetItemEntry(key, itemLink);
        end
        return numItems;
    end

    function _auroraCouncil:HandleStartMessage()
        Util:Print("Loot Distribution Started!");
    end

    function _auroraCouncil:HandleItemMessage(itemLink)
        Util:Print("Item: " .. itemLink);
    end

    function _auroraCouncil:HandleLootMessage(itemLink)
        UI.LootOfferFrame:OpenFrame();
        UI.LootOfferFrame:SetItem(itemLink);
    end

    function _auroraCouncil:ShowStartupMessage()
        Util:Print("Enabled!");
    end

    function _auroraCouncil:AddLootOption(option)
        UI.LootOfferFrame:AddOption(option);
    end

    function _auroraCouncil:SelectOption(response, player)
        local option, item = Message:SplitSelectOptionResponse(response);
        UI.RaidResponseFrame:AddPlayerEntry(option, player, item)
    end


    return _auroraCouncil;
end

