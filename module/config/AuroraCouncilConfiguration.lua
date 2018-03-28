AuroraCouncilConfiguration = {};

function AuroraCouncilConfiguration:New()
    local _configuration = {}

    local DESC_ENABLE = "Enable AuroraCouncil";
    local DESC_RESET = "Resets AuroraCouncil to the default state"
    local DESC_OPTIONS = "Setup available options for looting";
    local DESC_OPTIONS_COUNT = "Number of possible loot responses";
    local DESC_SET_OPT_VISIBLE = "Show Option in Overview";
    local DESC_SET_OPT_TEXT = "Set option name (max 10 characters)";

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
                    _configuration:Reset();
                end,
            },
            options = {
                type= 'group',
                desc= DESC_OPTIONS,
                name= "options",
                args= {
                    count = {
                        name = "count",
                        type = "range",
                        desc = DESC_OPTIONS_COUNT,
                        min = 2,
                        max = 6,
                        step = 1,
                        set = function(count)
                            _configuration:SetEnabledOptionsCount(count);
                        end,
                        get = function()
                            return _configuration:GetEnabledOptionsCount();
                        end,
                    },
                    opt1 = {
                        type='group',
                        desc='Option 1',
                        name="option1",
                        args={
                            visible = {
                                name = "enable",
                                type = "toggle",
                                desc = DESC_SET_OPT_VISIBLE,
                                set = function(visible)
                                    _configuration:SetOptionVisible(1, visible);
                                end,
                                get = function()
                                    return _configuration:IsOptionVisible(1);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    _configuration:SetOptionText(1, name);
                                end,
                                get = function()
                                    return _configuration:GetOptionText(1);
                                end,
                                validate = function(name)
                                    return string.len(name) < 16;
                                end
                            },
                        }
                    },
                    opt2 = {
                        type='group',
                        desc='Option 2',
                        name="option2",
                        args={
                            visible = {
                                name = "enable",
                                type = "toggle",
                                desc = DESC_SET_OPT_VISIBLE,
                                set = function(visible)
                                    _configuration:SetOptionVisible(2, visible);
                                end,
                                get = function()
                                    return _configuration:IsOptionVisible(2);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    _configuration:SetOptionText(2, name);
                                end,
                                get = function()
                                    return _configuration:GetOptionText(2);
                                end,
                                validate = function(name)
                                    return string.len(name) < 16;
                                end
                            },
                        }
                    },
                    opt3 = {
                        type='group',
                        desc='Option 3',
                        name="option3",
                        args={
                            visible = {
                                name = "enable",
                                type = "toggle",
                                desc = DESC_SET_OPT_VISIBLE,
                                set = function(visible)
                                    _configuration:SetOptionVisible(3, visible);
                                end,
                                get = function()
                                    return _configuration:IsOptionVisible(3);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    _configuration:SetOptionText(3, name);
                                end,
                                get = function()
                                    return _configuration:GetOptionText(3);
                                end,
                                validate = function(name)
                                    return string.len(name) < 16;
                                end
                            },
                        }
                    },
                    opt4 = {
                        type='group',
                        desc='Option 4',
                        name="option4",
                        args={
                            visible = {
                                name = "enable",
                                type = "toggle",
                                desc = DESC_SET_OPT_VISIBLE,
                                set = function(visible)
                                    _configuration:SetOptionVisible(4, visible);
                                end,
                                get = function()
                                    return _configuration:IsOptionVisible(4);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    _configuration:SetOptionText(4, name);
                                end,
                                get = function()
                                    return _configuration:GetOptionText(4);
                                end,
                                validate = function(name)
                                    return string.len(name) < 16;
                                end
                            },
                        }
                    },
                    opt5 = {
                        type='group',
                        desc='Option 5',
                        name="option5",
                        args={
                            visible = {
                                name = "enable",
                                type = "toggle",
                                desc = DESC_SET_OPT_VISIBLE,
                                set = function(visible)
                                    _configuration:SetOptionVisible(5, visible);
                                end,
                                get = function()
                                    return _configuration:IsOptionVisible(5);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    _configuration:SetOptionText(5, name);
                                end,
                                get = function()
                                    return _configuration:GetOptionText(5);
                                end,
                                validate = function(name)
                                    return string.len(name) < 16;
                                end
                            },
                        }
                    },
                    opt6 = {
                        type='group',
                        desc='Option 6',
                        name="option6",
                        args={
                            visible = {
                                name = "enable",
                                type = "toggle",
                                desc = DESC_SET_OPT_VISIBLE,
                                set = function(visible)
                                    _configuration:SetOptionVisible(6, visible);
                                end,
                                get = function()
                                    return _configuration:IsOptionVisible(6);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    _configuration:SetOptionText(6, name)
                                end,
                                get = function()
                                    return _configuration:GetOptionText(6)
                                end,
                                validate = function(name)
                                    return string.len(name) <= 10;
                                end
                            },
                        }
                    }
                }
            }
        },
    }

    function _configuration:SetEnabled(isEnabled)
        self.enabled = isEnabled;
    end

    function _configuration:IsEnabled()
        return self.enabled;
    end

    function _configuration:SetEnabledOptionsCount(count)
        self.numLootOptions = count;
    end

    function _configuration:GetEnabledOptionsCount()
        return self.numLootOptions;
    end

    function _configuration:SetOptionVisible(optionNum, visible)
        self.lootOptions[optionNum].visible = visible;
    end

    function _configuration:IsOptionVisible(optionNum)
        return self.lootOptions[optionNum].visible;
    end

    function _configuration:SetOptionText(optionNum, optionText)
        self.lootOptions[optionNum].text = string.gsub(optionText, ";", ",");
    end

    function _configuration:GetOptionText(optionNum)
        return self.lootOptions[optionNum].text;
    end

    function _configuration:GetChatCommands()
        return self.chatCommands;
    end

    function _configuration:GetLootOptions()
        return self.numLootOptions, self.lootOptions;
    end

    return _configuration
end
