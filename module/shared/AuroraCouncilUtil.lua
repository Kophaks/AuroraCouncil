AuroraCouncilUtil = {};

function AuroraCouncilUtil:Export()
    local _util = {};

    function _util:GetItemId(link)
        local _, _, _, Ltype, Id = string.find(link,
            "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?");
        return Ltype .. ":" .. Id;
    end

    function _util:Print(inputString)
        if inputString == nil then
            inputString = "nil"
        end
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFC59|| AuroraCouncil || |r" .. inputString);
    end

    function _util:Debug(inputString)
        if inputString == nil then
            inputString = "nil"
        end
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF7060|| AuroraCouncil || |r" .. inputString);
    end

    function _util:SplitString(inputString, seperator)
        local resultArray={} ;
        local pos=1;
        for str in string.gfind(inputString, "([^"..seperator.."]+)") do
            resultArray[pos] = str
            pos = pos + 1
        end
        return resultArray
    end

function _util:IsPlayerLootMaster()
    local _, masterlooterPartyID, _ = GetLootMethod()
    return masterlooterPartyID == 0;
end


    return _util;
end