AuroraCouncilUtil = {};

function AuroraCouncilUtil:Export()
    local _util = {};

    function _util:GetItemId(link)
        local _, _, _, Ltype, Id = string.find(link,
            "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?");
        return Ltype .. ":" .. Id;
    end

    function _util:GetItemEquippedSlot(link)
        local id = self:GetItemId(link);
        local _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(id);
        if itemEquipLoc == 'INVTYPE_HEAD' then return "HeadSlot";
        elseif itemEquipLoc == 'INVTYPE_NECK' then return "NeckSlot";
        elseif itemEquipLoc == 'INVTYPE_SHOULDER' then return "ShoulderSlot";
        elseif itemEquipLoc == 'INVTYPE_CHEST' then return "ChestSlot";
        elseif itemEquipLoc == 'INVTYPE_ROBE' then return "ChestSlot";
        elseif itemEquipLoc == 'INVTYPE_WAIST' then return "WaistSlot";
        elseif itemEquipLoc == 'INVTYPE_LEGS' then return "LegsSlot";
        elseif itemEquipLoc == 'INVTYPE_FEET' then return "FeetSlot";
        elseif itemEquipLoc == 'INVTYPE_WRIST' then return "WristSlot";
        elseif itemEquipLoc == 'INVTYPE_HAND' then return "HandsSlot";
        elseif itemEquipLoc == 'INVTYPE_FINGER' then return "Finger0Slot";
        elseif itemEquipLoc == 'INVTYPE_TRINKET' then return "Trinket0Slot";
        elseif itemEquipLoc == 'INVTYPE_CLOAK' then return "BackSlot";
        elseif itemEquipLoc == 'INVTYPE_WEAPON' then return "MainHandSlot";
        elseif itemEquipLoc == 'INVTYPE_SHIELD' then return "SecondaryHandSlot";
        elseif itemEquipLoc == 'INVTYPE_2HWEAPON' then return "MainHandSlot";
        elseif itemEquipLoc == 'INVTYPE_WEAPONMAINHAND' then return "MainHandSlot";
        elseif itemEquipLoc == 'INVTYPE_WEAPONOFFHAND' then return "SecondaryHandSlot";
        elseif itemEquipLoc == 'INVTYPE_HOLDABLE' then return "SecondaryHandSlot";
        elseif itemEquipLoc == 'INVTYPE_RANGED' then return "RangedSlot";
        elseif itemEquipLoc == 'INVTYPE_THROWN' then return "RangedSlot";
        elseif itemEquipLoc == 'INVTYPE_RANGEDRIGHT' then return "RangedSlot";
        elseif itemEquipLoc == 'INVTYPE_RELIC' then return "AmmoSlot ";
        else return nil
        end
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