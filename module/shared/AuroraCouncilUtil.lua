AuroraCouncilUtil = {};

function AuroraCouncilUtil:Export()
    local _util = {};

    function _util:GetItemId(link)
        local _, _, _, Ltype, Id = string.find(link,
            "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?");
        return Ltype .. ":" .. Id;
    end

    function _util:Print(string)
        if string == nil then
            string = "nil"
        end
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFC59|| AuroraCouncil || |r" .. string);
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


    return _util;
end