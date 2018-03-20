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
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFC59| AuroraCouncil | |r" .. string);
    end


    return _util;
end