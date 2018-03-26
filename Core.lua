Core = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0")
local AuroraCouncil = AuroraCouncil:Export();
local Config = AuroraCouncilConfiguration:Export(AuroraCouncil);

Core:RegisterChatCommand({"/ac"}, Config:GetOptions())

function Core:OnInitialize()
end

function Core:OnEnable()
    AuroraCouncil:ShowStartupMessage();
    self:RegisterEvent("CHAT_MSG_ADDON");
    self:RegisterEvent("LOOT_OPENED");
    AuroraCouncil:Init();
end

function Core:OnDisable()
end

function Core:LOOT_OPENED()
    AuroraCouncil:LootOpened();
end

function Core:CHAT_MSG_ADDON(prefix, message, _, sender)
    AuroraCouncil:ChatMsgAddon(prefix, message, sender);
end