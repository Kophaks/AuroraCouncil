AuroraCouncilConfiguration = {};

function AuroraCouncilConfiguration:Export(auroraCouncil)
    local _configuration = {}

    _configuration.options = {
        type='group',
        args = {
            enable = {
                name = "enable",
                type = "execute",
                desc = "Enable AuroraCouncil",
                func = function()
                    auroraCouncil:Enable(true)
                end,
            },
            disable = {
                name = "disable",
                type = "execute",
                desc = "Disable AuroraCouncil",
                func = function()
                    auroraCouncil:Enable(false)
                end,
            },
        },
    }

    function _configuration:GetOptions()
        return self.options;
    end

    return _configuration
end
