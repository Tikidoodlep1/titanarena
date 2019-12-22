function OutOfDuals(trigger)
local point = Entities:FindByName(nil, trigger.caller:GetName()):GetAbsOrigin()
	_G.DualTeleportTargetManaOut = trigger.activator:GetMana()
	print("current mana is ".._G.DualTeleportTargetManaOut)
	trigger.activator:SetMana(0)
end

function TeleportOut(trigger)
local playerloc = trigger.activator:GetAbsOrigin()
local closest = Entities:FindByNameNearest("dual_keepout", playerloc, 5000):GetAbsOrigin()
	trigger.activator:SetMana(_G.DualTeleportTargetManaOut)
	FindClearSpaceForUnit(trigger.activator, closest, false)
	SendToConsole("dota_camera_center")
end

function InDuals(trigger)
local point = Entities:FindByName(nil, trigger.caller:GetName()):GetAbsOrigin()

_G.DualTeleportTargetMana = trigger.activator:GetMana()
trigger.activator:SetMana(0)
end

function TeleportIn(trigger)
local closest = nil
for i, hero in pairs(_G.DualArena1) do
	if trigger.activator == hero then
	closest = _G.arena1
	end
end
for i, hero in pairs(_G.DualArenavs1) do
	if trigger.activator == hero then
	closest = _G.arena1vs
	end
end
for i, hero in pairs(_G.DualArena2) do
	if trigger.activator == hero then
	closest = _G.arena2
	end
end
for i, hero in pairs(_G.DualArenavs2) do
	if trigger.activator == hero then
	closest = _G.arena2vs
	end
end
trigger.activator:SetMana(_G.DualTeleportTargetMana)
FindClearSpaceForUnit(trigger.activator, closest, false)
SendToConsole("dota_camera_center")
end

