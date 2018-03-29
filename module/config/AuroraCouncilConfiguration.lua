AuroraCouncilConfiguration = {};

function AuroraCouncilConfiguration:New(Util)

    local _configuration = AceLibrary("AceAddon-2.0"):new("AceDB-2.0")

    local DESC_ENABLE = "Enable AuroraCouncil.";
    local DESC_RESET = "Resets AuroraCouncil to the default state."
    local DESC_INFO = "Show LootCouncil Homepage"
    local DESC_SET_OPTIONS = "Set all options/visibility at once, add '~' before option to hide in overview, option text max characters = 10.";

    _configuration.DEFAULT_NUM_OPTIONS = 3;
    _configuration.DEFAULT_OPTIONS = {
        [1] = {
            visible = true;
            text = "Need";
        },
        [2] = {
            visible = true;
            text = "Greed";
        },
        [3] = {
            visible = true;
            text = "Pass";
        },
        [4] = {
            visible = false;
            text = "nil";
        },
        [5] = {
            visible = false;
            text = "nil";
        },
        [6] = {
            visible = false;
            text = "nil";
        },
    }

    _configuration.onReset = nil;

    _configuration.enabled = true;

    _configuration.lootOptions = {};

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
            info = {
                name = "info",
                type = "execute",
                desc = DESC_INFO,
                func = function()
                    Util:Print("Visit https://mithnar.github.io/AuroraCouncil/ for more information");
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

    _configuration:RegisterDB("AuroraCouncilDB", "AuroraCouncilDBPC")
    _configuration:RegisterDefaults("char", {
        numOptions = _configuration.DEFAULT_NUM_OPTIONS,
        options = _configuration.DEFAULT_OPTIONS,
    } )

    function _configuration:SetEnabled(isEnabled)
        self.enabled = isEnabled;
    end

    function _configuration:IsEnabled()
        return self.enabled;
    end

    function _configuration:SetOptions(options)
        local splitOptions = Util:SplitString(options, ";")


        if splitOptions[1] ~= nil and splitOptions[2] ~= nil then
            for optionIndex = 1, 6 do
                if splitOptions[optionIndex] ~= nil then
                    self.db.char.options[optionIndex].visible = not Util:StringStartsWith(splitOptions[optionIndex], "~")
                    if self.db.char.options[optionIndex].visible then
                        self.db.char.options[optionIndex].text = splitOptions[optionIndex];
                    else
                        self.db.char.options[optionIndex].text = string.sub(splitOptions[optionIndex],2,string.len(splitOptions[optionIndex]))
                    end
                    self.db.char.numOptions = optionIndex;
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
        for optionIndex = 1, self.db.char.numOptions do
            if not self.db.char.options[optionIndex].visible then options = options .. "~" end
            options = options .. self.db.char.options[optionIndex].text
            if optionIndex ~= self.db.char.numOptions then options = options .. ";" end
        end
        return options;
    end

    function _configuration:GetChatCommands()
        return self.chatCommands;
    end

    function _configuration:GetLootOptions()
        return self.db.char.numOptions, self.db.char.options;
    end

    function _configuration:SetOnReset(onReset)
        self.onReset = onReset;
    end

    return _configuration
end
