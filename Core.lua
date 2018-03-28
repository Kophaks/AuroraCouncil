Core = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0")
local AuroraCouncil = AuroraCouncil:New();
local Config = AuroraCouncilConfiguration:New(AuroraCouncil);

Core:RegisterChatCommand({"/ac"}, Config:GetOptions())

function Core:OnInitialize()
end

function Core:OnEnable()
    AuroraCouncil:ShowStartupMessage();
    self:RegisterEvent("CHAT_MSG_ADDON");
    self:RegisterEvent("LOOT_OPENED");
    self:RegisterEvent("LOOT_CLOSED");
    self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    AuroraCouncil:Init();
end

function Core:OnDisable()
end

function Core:LOOT_OPENED()
    AuroraCouncil:LootOpened();
end

function Core:LOOT_CLOSED()
    AuroraCouncil:LootClosed();
end

function Core:CHAT_MSG_ADDON(prefix, message, _, sender)
    AuroraCouncil:ChatMsgAddon(prefix, message, sender);
end

function Core:PARTY_LOOT_METHOD_CHANGED()
    AuroraCouncil:LootMethodChanged();
end

function Core:PLAYER_ENTERING_WORLD()
    AuroraCouncil:PlayerEnteringWorld();
end