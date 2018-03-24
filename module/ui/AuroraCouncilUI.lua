AuroraCouncilUI = {};

local lootMasterFrame = AuroraCouncilLootMasterFrame:Export();
local lootOfferFrame = AuroraCouncilLootOfferFrame:Export();
local raidResponseFrame = AuroraCouncilRaidResponseFrame:Export();

function AuroraCouncilUI:Export()
    local _ui = {};

    _ui.LootMasterFrame = lootMasterFrame;
    _ui.LootOfferFrame = lootOfferFrame;
    _ui.RaidResponseFrame = raidResponseFrame;

    function _ui:UpdateState(stateMachine)
        if stateMachine.current.name == stateMachine.WATING then
            self:HandleWaitingState();
        elseif stateMachine.current.name == stateMachine.LOOT then
            self:HandleLootState();
        elseif stateMachine.current.name == stateMachine.MASTER_LOOTING then
            self:HandleMasterLootingState();
        elseif stateMachine.current.name == stateMachine.MASTER_SELECT_OPTION then
            self:HandleMasterSelectOptionState();
        elseif stateMachine.current.name == stateMachine.MASTER_DECISION then
            self:HandleMasterDecisionState();
        elseif stateMachine.current.name == stateMachine.AWAIT_ITEM then
            self:HandleAwaitItemState();
        elseif stateMachine.current.name == stateMachine.SELECT_OPTION then
            self:HandleSelectOptionState();
        elseif stateMachine.current.name == stateMachine.AWAIT_DECISION then
            self:HandleAwaitDecisionState();
        end
    end

    function _ui:HandleWaitingState()
        self.LootMasterFrame:CloseFrame();
        self.LootOfferFrame:CloseFrame();
        self.RaidResponseFrame:CloseFrame();
    end

    function _ui:HandleLootState()
        self.LootMasterFrame:CloseFrame();
        self.LootOfferFrame:CloseFrame();
        self.RaidResponseFrame:CloseFrame();
    end

    function _ui:HandleMasterLootingState()
        self.LootMasterFrame:OpenFrame();
        self.LootOfferFrame:CloseFrame();
        self.RaidResponseFrame:CloseFrame();
    end

    function _ui:HandleMasterSelectOptionState()
        self.LootMasterFrame:OpenFrame();
        self.LootOfferFrame:OpenFrame();
        self.RaidResponseFrame:CloseFrame();
    end

    function _ui:HandleMasterDecisionState()
        self.LootMasterFrame:OpenFrame();
        self.LootOfferFrame:CloseFrame();
        self.RaidResponseFrame:OpenFrame();
    end

    function _ui:HandleAwaitItemState()
        self.LootMasterFrame:CloseFrame();
        self.LootOfferFrame:CloseFrame();
        self.RaidResponseFrame:CloseFrame();
    end

    function _ui:HandleSelectOptionState()
        self.LootMasterFrame:CloseFrame();
        self.LootOfferFrame:OpenFrame();
        self.RaidResponseFrame:CloseFrame();
    end

    function _ui:HandleAwaitDecisionState()
        self.LootMasterFrame:CloseFrame();
        self.LootOfferFrame:CloseFrame();
        self.RaidResponseFrame:OpenFrame();
    end

    function _ui:Init()
        self.LootMasterFrame:OpenFrame();
        self.LootOfferFrame:OpenFrame();
        self.RaidResponseFrame:OpenFrame();
        self.LootMasterFrame:ResetFrame();
        self.LootOfferFrame:ResetFrame();
        self.RaidResponseFrame:ResetFrame();
        self.LootMasterFrame:CloseFrame();
        self.LootOfferFrame:CloseFrame();
        self.RaidResponseFrame:CloseFrame();
    end


    return _ui;
end