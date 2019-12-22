function OutOfDuals(trigger)
local point = Entities:FindByName(nil, trigger.caller:GetName()):GetAbsOrigin()



local DualTeleportTargetMana = trigger.activator:GetMana()

trigger.activator:SetMana(0)
trigger.activator:Stop()
trigger.activator:Interrupt()
trigger.activator:SetMana(DualTeleportTargetMana)
end

function InDuals(trigger)
local point = Entities:FindByName(nil, trigger.caller:GetName()):GetAbsOrigin()
local playerloc = trigger.activator:GetAbsOrigin()

local DualTeleportTargetMana = trigger.activator:GetMana()

trigger.activator:SetMana(0)
trigger.activator:Stop()
trigger.activator:Interrupt()
trigger.activator:SetMana(DualTeleportTargetMana)
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
for i, hero in pairs(_G.DualArena1) do
	if trigger.activator == hero then
	closest = _G.arena2
	end
end
for i, hero in pairs(_G.DualArenavs1) do
	if trigger.activator == hero then
	closest = _G.arena2vs
	end
end

FindClearSpaceForUnit(trigger.activator, closest, false)
SendToConsole("dota_camera_center")

end

function TeleportOut(trigger)
local playerloc = trigger.activator:GetAbsOrigin()
local closest = Entities:FindByNameNearest("dual_keepout", playerloc, 5000):GetAbsOrigin()

FindClearSpaceForUnit(trigger.activator, closest, false)
SendToConsole("dota_camera_center")
end