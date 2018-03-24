local UI = AuroraCouncilUI:Export();
local Message = AuroraCouncilMessage:Export();
local Util = AuroraCouncilUtil:Export();
local StateMachine = AuroraCouncilStateMachine:Export();

AuroraCouncil = {};

function AuroraCouncil:Export()
    local _auroraCouncil = {};
    local lootTable;

    function _auroraCouncil:LootOpened()
        if StateMachine.current.name == StateMachine.WATING then
            Message:SendResetRequest("RAID");
            local itemCount = self:InitializeCouncil();
            UI.LootMasterFrame:ResizeFrame(itemCount);
        end
    end

    function _auroraCouncil:LootClosed()

    end

    function _auroraCouncil:Init()
        UI:Init();
    end

    function _auroraCouncil:ChatMsgAddon(prefix, message, sender)
        if prefix == Message.RESET then
            self:HandleResetMessage();
        end
        if prefix == Message.MASTER_IS_LOOTING then
            self:HandleMasterIsLooting();
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
        UI:UpdateState(StateMachine);
    end

    function _auroraCouncil:InitializeCouncil()
        local numItems = 0;
        if self:CheckPreconditions() then
            Message:SendMasterIsLootingInfo("Raid");
            lootTable = {};
            local numLoots = GetNumLootItems();
            numItems = 0;
            if numLoots > 0 then
                Message:SendSessionStartRequest("Raid");
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
        end
        return numItems;
    end

    function _auroraCouncil:HandleStartMessage(sender)
        Util:Print("Loot Distribution Started!");
        Util:Print("Loot Master: " .. sender);
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

    function _auroraCouncil:HandleResetMessage()
        StateMachine:Reset();
        UI:Init();
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

