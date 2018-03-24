local Util = AuroraCouncilUtil:Export();

AuroraCouncilMessage = {};

function AuroraCouncilMessage:Export()

    local _message = {};

    _message.RESET = "AUCO_LMRES";
    _message.MASTER_IS_LOOTING = "AUCO_LMLOOT";
    _message.SESSION_START = "AUCO_START";
    _message.SHOW_ITEM = "AUCO_ITEM";
    _message.OFFER_ITEM = "AUCO_OFFER";
    _message.SET_OPTIONS = "AUCO_ADDOPTION";
    _message.SELECT_OPTION = "AUCO_SELECTOPTION";

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

    function _message:SendSessionStartRequest(channel)
        SendAddonMessage(self.SESSION_START, "-", channel);
    end

    function _message:SendSetOptionsRequest(options, channel)
        SendAddonMessage(self.SET_OPTIONS, options, channel);
    end

    function _message:SendSelectOptionRequest(option, currentItem, channel)
        SendAddonMessage(self.SELECT_OPTION, option .. ';' .. currentItem, channel);
    end

    function _message:CreateOfferItemRequest(itemLink, option1, option2, option3, option4, option5)
        local request;

        request = itemLink .. ";" .. option1;

        if option2 then
            request = request .. ";" .. option2;
        end
        if option3 then
            request = request .. ";" .. option3;
        end
        if option4 then
            request = request .. ";" .. option4;
        end
        if option5 then
            request = request .. ";" .. option5;
        end

        return request;
    end

    function _message:SplitOfferItemRequest(message)
        local message = Util:SplitString(message, ";")
        local itemLink = message[1];
        local option1 = message[2];
        local option2 = message[3];
        local option3 = message[4];
        local option4 = message[5];
        local option5 = message[6];
        return itemLink, option1, option2, option3, option4, option5;
    end

    function _message:SplitSelectOptionMessage(message)
        local selectionInfo = Util:SplitString(message, ";")
        local option = selectionInfo[1];
        local item = selectionInfo[2];
        return option, item;
    end

    return _message;
end