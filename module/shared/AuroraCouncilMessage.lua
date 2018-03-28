local Util = AuroraCouncilUtil:Export();

AuroraCouncilMessage = {};

function AuroraCouncilMessage:Export()

    local _message = {};

    _message.RESET = "AUCO_LMRES";
    _message.MASTER_IS_LOOTING = "AUCO_LMLOOT";
    _message.NO_ITEMS = "AUCO_NOITEM";
    _message.SESSION_START = "AUCO_START";
    _message.SHOW_ITEM = "AUCO_ITEM";
    _message.SELECT_ITEM = "AUCO_SELECTITEM";
    _message.OFFER_ITEM = "AUCO_OFFER";
    _message.SET_OPTIONS = "AUCO_ADDOPTION";
    _message.SELECT_OPTION = "AUCO_SELECTOPTION";
    _message.GIVE_ITEM = "AUCO_GIVEITEM";
    _message.ITEM_ASSIGNED = "AUCO_ASSIGNED";

    function _message:SendResetRequest(channel)
        SendAddonMessage(self.RESET, "-", channel);
    end

    function _message:SendMasterIsLootingInfo(channel)
        SendAddonMessage(self.MASTER_IS_LOOTING, "-", channel);
    end

    function _message:SendShowItemInfo(itemLink, channel)
        SendAddonMessage(self.SHOW_ITEM, itemLink, channel);
    end

    function _message:SendOfferItemRequest(offerItemRequest, channel)
        SendAddonMessage(self.OFFER_ITEM, offerItemRequest, channel);
    end

    function _message:SendItemSelectedRequest(itemLink, channel)
        SendAddonMessage(self.SELECT_ITEM, itemLink, channel);
    end

    function _message:SendSessionStartRequest(channel)
        SendAddonMessage(self.SESSION_START, "-", channel);
    end

    function _message:SendSetOptionsRequest(options, channel)
        SendAddonMessage(self.SET_OPTIONS, options, channel);
    end

    function _message:SendSelectOptionRequest(option, currentItem, channel)
        if currentItem == nil then currentItem = "-"; end
        local visible = 0;
        if option.visible then visible = 1 end;
        SendAddonMessage(self.SELECT_OPTION, option.text .. ';' .. visible .. ';' .. currentItem, channel);
    end

    function _message:NoValidItemsInfo(channel)
        SendAddonMessage(self.NO_ITEMS, "-", channel);
    end

    function _message:SendGiveItemRequest(player, channel)
        SendAddonMessage(self.GIVE_ITEM, player, channel);
    end

    function _message:SendItemAssignedInfo(channel)
        SendAddonMessage(self.ITEM_ASSIGNED, "-", channel);
    end

    function _message:CreateOfferItemRequest(itemLink, numOptions, option1, option2, option3, option4, option5, option6)
        local request;
        local visible;
        if option1.visible == true then visible = 1 else visible = 0 end;
        request = itemLink .. ";" .. numOptions .. ";" .. option1.text .. ";" .. visible;

        if option2 then
            if option2.visible == true then visible = 1 else visible = 0 end;
            request = request .. ";".. option2.text .. ";" .. visible;
        end
        if option3 then
            if option3.visible == true then visible = 1 else visible = 0 end;
            request = request .. ";" .. option3.text .. ";" .. visible;
        end
        if option4 then
            if option4.visible == true then visible = 1 else visible = 0 end;
            request = request .. ";" .. option4.text .. ";" .. visible;
        end
        if option5 then
            if option5.visible == true then visible = 1 else visible = 0 end;
            request = request .. ";" .. option5.text .. ";" .. visible;
        end
        if option6 then
            if option6.visible == true then visible = 1 else visible = 0 end;
            request = request .. ";" .. option6.text .. ";" .. visible;
        end

        return request;
    end

    function _message:SplitOfferItemRequest(message)
        local message = Util:SplitString(message, ";")
        local itemLink = message[1];
        local numOptions = message[2];
        local option1 = {};
        option1.text = message[3];
        option1.visible = message[4] == "1";
        local option2 = {};
        option2.text = message[5];
        option2.visible = message[6] == "1";
        local option3 = {};
        option3.text = message[7];
        option3.visible = message[8] == "1";
        local option4 = {};
        option4.text = message[9];
        option4.visible = message[10] == 1;
        local option5 = {};
        option5.text = message[11];
        option5.visible = message[12] == 1;
        local option6 = {};
        option6.text = message[13];
        option6.visible = message[14] == 1;
        return itemLink, numOptions, option1, option2, option3, option4, option5, option6;
    end

    function _message:SplitSelectOptionMessage(message)
        local selectionInfo = Util:SplitString(message, ";")
        local option = {}
        option.text = selectionInfo[1];
        option.visible = selectionInfo[2] == "1";
        local item = selectionInfo[3];
        return option, item;
    end

    return _message;
end