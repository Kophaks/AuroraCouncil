local Util = AuroraCouncilUtil:Export();

AuroraCouncilStateMachine = {}

function AuroraCouncilStateMachine:Export()
    AuroraCouncilStateMachine.StateWaiting = {}
    AuroraCouncilStateMachine.StateLoot = {}
    AuroraCouncilStateMachine.StateMasterLooting = {}
    AuroraCouncilStateMachine.StateMasterSelectOption = {}
    AuroraCouncilStateMachine.StateMasterDecision = {}
    AuroraCouncilStateMachine.StateAwaitItem = {}
    AuroraCouncilStateMachine.StateSelectOption = {}
    AuroraCouncilStateMachine.StateAwaitDecision = {}

    AuroraCouncilStateMachine.StateWaiting.name = "ACST_WAITING"
    AuroraCouncilStateMachine.StateLoot.name = "ACST_LOOT"
    AuroraCouncilStateMachine.StateMasterLooting.name = "ACST_LOOTING"
    AuroraCouncilStateMachine.StateMasterSelectOption.name = "ACST_LM_SELECT_OPTION"
    AuroraCouncilStateMachine.StateMasterDecision.name = "ACST_LM_DECISION"
    AuroraCouncilStateMachine.StateAwaitItem.name = "ACST_AWAIT_ITEM"
    AuroraCouncilStateMachine.StateSelectOption.name = "ACST_SELECT_OPTION"
    AuroraCouncilStateMachine.StateAwaitDecision.name = "ACST_AWAIT_DECISION"

    local _state = {}
    _state.current = AuroraCouncilStateMachine.StateWaiting;

    function AuroraCouncilStateMachine.StateWaiting:LootItem()
        Util:Debug("Waiting -> Loot");
        _state.current = AuroraCouncilStateMachine.StateLoot;
    end

    function AuroraCouncilStateMachine.StateLoot:NoLoot()
        Util:Debug("Loot -> Waiting");
        _state.current = AuroraCouncilStateMachine.StateWaiting;
    end

    function AuroraCouncilStateMachine.StateLoot:SomeLoot(lootMaster)
        if lootMaster then
            Util:Debug("Loot -> MasterLooting");
            _state.current = AuroraCouncilStateMachine.StateMasterLooting;
        else
            Util:Debug("Loot -> AwaitItem");
            _state.current = AuroraCouncilStateMachine.StateAwaitItem;
        end
    end

    function AuroraCouncilStateMachine.StateMasterLooting:ChooseItem()
        Util:Debug("MasterLooting -> MasterSelectOption");
        _state.current = AuroraCouncilStateMachine.StateMasterSelectOption;
    end

    function AuroraCouncilStateMachine.StateMasterSelectOption:ChooseOption()
        Util:Debug("MasterSelectOption -> MasterDecision");
        _state.current = AuroraCouncilStateMachine.StateMasterDecision;
    end

    function AuroraCouncilStateMachine.StateMasterDecision:AssignItem()
        Util:Debug("MasterDecision -> Loot");
        _state.current = AuroraCouncilStateMachine.StateLoot;
    end

    function AuroraCouncilStateMachine.StateAwaitItem:ReceiveOptions()
        Util:Debug("AwaitItem -> SelectOption");
        _state.current = AuroraCouncilStateMachine.StateSelectOption;
    end

    function AuroraCouncilStateMachine.StateSelectOption:ChooseOption()
        Util:Debug("SelectOption -> AwaitDecision");
        _state.current = AuroraCouncilStateMachine.StateAwaitDecision;
    end

    function AuroraCouncilStateMachine.StateAwaitDecision:AssignItem()
        Util:Debug("AwaitDecision -> Loot");
        _state.current = AuroraCouncilStateMachine.StateLoot;
    end

    _state.WATING = AuroraCouncilStateMachine.StateWaiting.name
    _state.LOOT = AuroraCouncilStateMachine.StateLoot.name
    _state.MASTER_LOOTING = AuroraCouncilStateMachine.StateMasterLooting.name
    _state.MASTER_SELECT_OPTION = AuroraCouncilStateMachine.StateMasterSelectOption.name
    _state.MASTER_DECISION = AuroraCouncilStateMachine.StateMasterDecision.name
    _state.AWAIT_ITEM = AuroraCouncilStateMachine.StateAwaitItem.name
    _state.SELECT_OPTION = AuroraCouncilStateMachine.StateSelectOption.name
    _state.AWAIT_DECISION = AuroraCouncilStateMachine.StateAwaitDecision.name

    function _state:Reset()
        _state.current = AuroraCouncilStateMachine.StateWaiting;
    end

    return _state;

end