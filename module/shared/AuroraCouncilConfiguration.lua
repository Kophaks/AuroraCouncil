AuroraCouncilConfiguration = {};

function AuroraCouncilConfiguration:Export(configurationHandler)
    local _configuration = {}

    local DESC_ENABLE = "Enable AuroraCouncil";
    local DESC_RESET = "Resets AuroraCouncil to the default state"
    local DESC_OPTIONS = "Setup available options for looting";
    local DESC_OPTIONS_COUNT = "Number of possible loot responses";
    local DESC_SET_OPT_VISIBLE = "Show Option in Overview";
    local DESC_SET_OPT_TEXT = "Set option name (max 10 characters)";

    _configuration.options = {
        type='group',
        args = {
            enable = {
                name = "enable",
                type = "toggle",
                desc = DESC_ENABLE,
                set = function(enabled)
                    configurationHandler:Enable(enabled);
                end,
                get = function()
                    return configurationHandler:IsEnabled();
                end,
            },
            reset = {
                name = "reset",
                type = "execute",
                desc = DESC_RESET,
                func = function()
                    configurationHandler:Reset();
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
                            configurationHandler:SetEnabledOptionsCount(count);
                        end,
                        get = function()
                            return configurationHandler:GetEnabledOptionsCount();
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
                                    configurationHandler:SetOptionVisible(1, visible);
                                end,
                                get = function()
                                    return configurationHandler:IsOptionVisible(1);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    configurationHandler:SetOptionText(1, name);
                                end,
                                get = function()
                                    return configurationHandler:GetOptionText(1);
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
                                    configurationHandler:SetOptionVisible(2, visible);
                                end,
                                get = function()
                                    return configurationHandler:IsOptionVisible(2);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    configurationHandler:SetOptionText(2, name);
                                end,
                                get = function()
                                    return configurationHandler:GetOptionText(2);
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
                                    configurationHandler:SetOptionVisible(3, visible);
                                end,
                                get = function()
                                    return configurationHandler:IsOptionVisible(3);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    configurationHandler:SetOptionText(3, name);
                                end,
                                get = function()
                                    return configurationHandler:GetOptionText(3);
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
                                    configurationHandler:SetOptionVisible(4, visible);
                                end,
                                get = function()
                                    return configurationHandler:IsOptionVisible(4);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    configurationHandler:SetOptionText(4, name);
                                end,
                                get = function()
                                    return configurationHandler:GetOptionText(4);
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
                                    configurationHandler:SetOptionVisible(5, visible);
                                end,
                                get = function()
                                    return configurationHandler:IsOptionVisible(5);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    configurationHandler:SetOptionText(5, name);
                                end,
                                get = function()
                                    return configurationHandler:GetOptionText(5);
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
                                    configurationHandler:SetOptionVisible(6, visible);
                                end,
                                get = function()
                                    return configurationHandler:IsOptionVisible(6);
                                end,
                            },
                            text = {
                                name = "name",
                                type = 'text',
                                desc = DESC_SET_OPT_TEXT,
                                usage = "<name>",
                                set = function(name)
                                    configurationHandler:SetOptionText(6, name)
                                end,
                                get = function()
                                    return configurationHandler:GetOptionText(6)
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

    function _configuration:GetOptions()
        return self.options;
    end

    return _configuration
end
