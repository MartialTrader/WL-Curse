-- Roblox Service Variables

local RS = game:GetService('ReplicatedService')
local Debris = game:GetService('Debris')
local TS = game:GetService('TweenService')

-- Player Variables

local Player = game.Players.LocalPlayer
local Character = Player.Character
local Mouse = Player:GetMouse()

-- MISC Variables

local BannedPlayers = {'avayliynn','scary_lord10'}
local noCursePlayers = {'DemolishSanity','DemolishSpirits','DemolishSaints'}

local CurrentSpell = nil
local CurrentTarget = nil

local curseCommand = ';curse '
local spellCommand = ';setspell '

_G.PatronusIncrement = 1

-- Toggles

_G.MASTER_KEY = true

_G.CurseToggle = false

-- Script

if Player.Name == table.find(BannedPlayers, Player.Name) then
		Player:Kick("You are on the 'BannedPlayers' list. Appeal at 	DemolishSanity#9999.")
end

local function returnPlayer(Name)
		local FoundPlayer
		if game.Players[Name].Name ~= table.find(noCursePlayers, Name) then
				FoundPlayer = Name
				return true
		end
		return false
end

local function addPatronus(p, c)
		if p.Energy.Value < 15 then
				p.Energy.Value = p.Energy.Value + _G.PatronusIncrement
		end
end

local function cursePlayer(target, spell)
		local v = (Mouse.Hit.p - Character.HumanoidRootPart.Position).unit
    local w = v * 3
    local y = workspace[target].UpperTorso.Position
    Player.PlayerGui.Client.fwp:Fire(y, w, true, q)
		RS.Events.ProjEvent:FireServer(y, w, spell)
end

local function onChatted(message, recipient)
		if message == string.sub(1, curseCommand.len()):lower() then
				local playerName = string.sub(curseCommand.len() + 1)
				
				if returnPlayer(playerName) then
						CurrentTarget = returnPlayer
						coroutine.resume(curseCoroutine)
				end
		end
end

local curseCoroutine = coroutine.create(function()
		while _G.CurseToggle == true and _G.MASTER_KEY == true do
				wait()
				cursePlayer(CurrentTarget, CurrentSpell)
		end
end)


