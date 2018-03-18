AuroraCouncil = {};

function AuroraCouncil:Export()
    local _auroraCouncil = {};
    local UI = AuroraCouncilUI:Export();
    local Message = AuroraCouncilMessage:Export();
    local Util = AuroraCouncilUtil:Export();

    -- PRIVATE
    local lootTable;

    -- PRIVATE END


    -- PUBLIC
    function _auroraCouncil:LootOpened()
        UI.LootMasterFrame:OpenLootMasterFrame();
        local itemCount = self:InitializeCouncil();
        UI.LootMasterFrame:ResizeLootMasterFrame(itemCount);
    end

    function _auroraCouncil:LootClosed()
        UI.LootMasterFrame:CloseLootMasterFrame();
    end

    function _auroraCouncil:ChatMsgAddon(prefix, message, sender)
       -- if sender ~= (UnitName("player")) then
            if prefix == Message.SESSION_START then
                self:HandleStartMessage();
            end
            if prefix == Message.SHOW_ITEM then
                self:HandleItemMessage(message);
            end
        --end
        if prefix == Message.OFFER_ITEM then
            self:HandleLootMessage(message);
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
                numItems = numItems+1;
                local itemLink = GetLootSlotLink(itemIndex);
                lootTable[numItems] = {itemIndex, itemLink};
            end
        end
        for key, value in pairs(lootTable) do
            local _, itemLink = unpack(value);
            Message:SendShowItemInfo(itemLink, "RAID")
            UI.LootMasterFrame:SetItemEntry(key, itemLink);
        end
        return numItems;
    end

    function _auroraCouncil:HandleStartMessage()
        Util:Print("Loot Distribution Started!");
    end

    function _auroraCouncil:HandleItemMessage(message)
        Util:Print("Item: " .. message);
    end

    function _auroraCouncil:HandleLootMessage(message)
        StaticPopupDialogs["EXAMPLE_HELLOWORLD"] = {
            text = "Do you need " .. message .. " ?",
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
                Util:Print("Good for you");
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3
        }
        StaticPopup_Show ("EXAMPLE_HELLOWORLD")
    end

    function _auroraCouncil:ShowStartupMessage()
        Util:Print("Enabled!")
    end

    -- PUBLIC END


    return _auroraCouncil;
end

