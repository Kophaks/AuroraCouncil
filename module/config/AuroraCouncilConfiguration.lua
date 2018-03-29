AuroraCouncilConfiguration = {};

function AuroraCouncilConfiguration:New(Util)
    local _configuration = {}

    local DESC_ENABLE = "Enable AuroraCouncil.";
    local DESC_RESET = "Resets AuroraCouncil to the default state."
    local DESC_SET_OPTIONS = "Set all options/visibility at once, add '~' before option to hide in overview, option text max characters = 10.";

    _configuration.onReset = nil;

    _configuration.enabled = true;

    _configuration.numLootOptions = 3;
    _configuration.lootOptions = {};
    _configuration.lootOptions[1] = {};
    _configuration.lootOptions[1].visible = true;
    _configuration.lootOptions[1].text = "Need";
    _configuration.lootOptions[2] = {};
    _configuration.lootOptions[2].visible = true;
    _configuration.lootOptions[2].text = "Greed";
    _configuration.lootOptions[3] = {};
    _configuration.lootOptions[3].visible = true;
    _configuration.lootOptions[3].text = "Pass";
    _configuration.lootOptions[4] = {};
    _configuration.lootOptions[4].visible = true;
    _configuration.lootOptions[4].text = "option4";
    _configuration.lootOptions[5] = {};
    _configuration.lootOptions[5].visible = true;
    _configuration.lootOptions[5].text = "option5";
    _configuration.lootOptions[6] = {};
    _configuration.lootOptions[6].visible = true;
    _configuration.lootOptions[6].text = "option6";


    _configuration.chatCommands = {
        type='group',
        args = {
            enable = {
                name = "enable",
                type = "toggle",
                desc = DESC_ENABLE,
                set = function(enabled)
                    _configuration:SetEnabled(enabled);
                end,
                get = function()
                    return _configuration:IsEnabled();
                end,
            },
            reset = {
                name = "reset",
                type = "execute",
                desc = DESC_RESET,
                func = function()
                    _configuration:onReset();
                end,
            },
            options = {
                name = "name",
                type = 'text',
                desc = DESC_SET_OPTIONS,
                usage = DESC_SET_OPTIONS,
                set = function(options)
                    _configuration:SetOptions(options);
                end,
                get = function()
                    return _configuration:GetOptions();
                end,
                validate = function(options)
                    return _configuration:ValidateOptionsString(options);
                end
            }
        },
    }

    function _configuration:SetEnabled(isEnabled)
        self.enabled = isEnabled;
    end

    function _configuration:IsEnabled()
        return self.enabled;
    end

    function _configuration:SetOptions(options)
        Util:Debug(options);
        local splitOptions = Util:SplitString(options, ";")


        if splitOptions[1] ~= nil and splitOptions[2] ~= nil then
            for optionIndex = 1, 6 do
                if splitOptions[optionIndex] ~= nil then
                    self.lootOptions[optionIndex].visible = not Util:StringStartsWith(splitOptions[optionIndex], "~")
                    if self.lootOptions[optionIndex].visible then
                        self.lootOptions[optionIndex].text = splitOptions[optionIndex];
                    else
                        self.lootOptions[optionIndex].text = string.sub(splitOptions[optionIndex],2,string.len(splitOptions[optionIndex]))
                    end
                    self.numLootOptions = optionIndex;
                end
            end
        else
            Util:Print("You need to set at least 2 options")
        end
    end

    function _configuration:ValidateOptionsString(options)
        local splitOptions = Util:SplitString(options, ";")
        for optionIndex = 1, 6 do
            if splitOptions[optionIndex] ~= nil then
                if string.len(splitOptions[optionIndex]) > 10 then
                    return false;
                end
            end
        end
        return true;
    end

    function _configuration:GetOptions()
        local options = "";
        for optionIndex = 1, self.numLootOptions do
            if not self.lootOptions[optionIndex].visible then options = options .. "~" end
            options = options .. self.lootOptions[optionIndex].text
            if optionIndex ~= self.numLootOptions then options = options .. ";" end
        end
        return options;
    end

    function _configuration:GetChatCommands()
        return self.chatCommands;
    end

    function _configuration:GetLootOptions()
        return self.numLootOptions, self.lootOptions;
    end

    function _configuration:SetOnReset(onReset)
        self.onReset = onReset;
    end

    return _configuration
end
