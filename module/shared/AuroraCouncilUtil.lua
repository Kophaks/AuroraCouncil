AuroraCouncilUtil = {};

-- EXPORT
function AuroraCouncilUtil:Export()
    local _util = {}

    -- PUBLIC
    function _util:GetItemId(link)
        local _, _, _, Ltype, Id = string.find(link,
            "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?");
        return Ltype .. ":" .. Id;
    end

    function _util:Print(string)
        if string == nil then
            string = "nil"
        end
        DEFAULT_CHAT_FRAME:AddMessage("AuroraCouncil | " .. string);
    end
    -- PUBLIC END

    return _util;
end