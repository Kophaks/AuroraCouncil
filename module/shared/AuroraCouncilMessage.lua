AuroraCouncilMessage = {};

function AuroraCouncilMessage:Export()
    local _message = {};

    -- PUBLIC
    _message.SESSION_START = "AUCO-START";
    _message.SHOW_ITEM = "AUCO-ITEM";
    _message.OFFER_ITEM = "AUCO-OFFER";

    function _message:SendShowItemInfo(itemLink, channel)
        SendAddonMessage( self.SHOW_ITEM, itemLink, channel );
    end

    function _message:SendOfferItemRequest(itemLink, channel)
        SendAddonMessage( self.OFFER_ITEM, itemLink, channel );
    end

    function _message:SendSessionStartRequest(channel)
        SendAddonMessage( self.SESSION_START, "-", channel );
    end

    -- PUBLIC END
    return _message;
end