local Util = AuroraCouncilUtil:Export();

AuroraCouncilMessage = {};

function AuroraCouncilMessage:Export()

    local _message = {};

    _message.SESSION_START = "AUCO-START";
    _message.SHOW_ITEM = "AUCO-ITEM";
    _message.OFFER_ITEM = "AUCO-OFFER";
    _message.ADD_OPTION = "AUCO-ADDOPTION"
    _message.SELECT_OPTION = "AUCO-SELECTOPTION"

    function _message:SendShowItemInfo(itemLink, channel)
        SendAddonMessage(self.SHOW_ITEM, itemLink, channel);
    end

    function _message:SendOfferItemRequest(itemLink, channel)
        SendAddonMessage(self.OFFER_ITEM, itemLink, channel);
    end

    function _message:SendSessionStartRequest(channel)
        SendAddonMessage(self.SESSION_START, "-", channel);
    end

    function _message:SendAddOptionRequest(option, channel)
        SendAddonMessage(self.ADD_OPTION, option, channel);
    end

    function _message:SendSelectOptionRequest(option, currentItem, channel)
        SendAddonMessage(self.SELECT_OPTION, option .. ';' .. currentItem, channel);
    end

    function _message:SplitSelectOptionResponse(response)
        local responseArray = Util:SplitString(response, ";")
        local option = responseArray[1];
        local item = responseArray[2];
        return option, item;
    end

    return _message;
end