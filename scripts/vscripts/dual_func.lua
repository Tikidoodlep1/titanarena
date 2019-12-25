function OutOfDuals(trigger)
local point = Entities:FindByName(nil, trigger.caller:GetName()):GetAbsOrigin()
	_G.DualTeleportTargetManaOut = trigger.activator:GetMana()
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
local arena = nil
local arena2 = nil
if _G.GetArena == 1 then
	arena = Entities:FindByName(nil, "dual_keepin3_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin4_trigger")
elseif _G.GetArena == 2 then
	arena = Entities:FindByName(nil, "dual_keepin4_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin3_trigger")
elseif _G.GetArena == 3 then
	arena = Entities:FindByName(nil, "dual_keepin1_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin2_trigger")
else 
	arena = Entities:FindByName(nil, "dual_keepin2_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin1_trigger")
end
for i, hero in pairs(_G.DualArena1) do
	if trigger.activator == hero and arena:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(0)
	end
end
for i, hero in pairs(_G.DualArenavs1) do
	if trigger.activator == hero and arena:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(0)
	end
end
for i, hero in pairs(_G.DualArena2) do
	if trigger.activator == hero and arena2:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(0)
	end
end
for i, hero in pairs(_G.DualArenavs2) do
	if trigger.activator == hero and arena2:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(0)
	end
end
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
local arena = nil
local arena2 = nil
if _G.GetArena == 1 then
	arena = Entities:FindByName(nil, "dual_keepin3_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin4_trigger")
elseif _G.GetArena == 2 then
	arena = Entities:FindByName(nil, "dual_keepin4_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin3_trigger")
elseif _G.GetArena == 3 then
	arena = Entities:FindByName(nil, "dual_keepin1_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin2_trigger")
else 
	arena = Entities:FindByName(nil, "dual_keepin2_trigger")
	arena2 = Entities:FindByName(nil, "dual_keepin1_trigger")
end
for i, hero in pairs(_G.DualArena1) do
	if trigger.activator == hero and arena:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(_G.DualTeleportTargetMana)
		FindClearSpaceForUnit(trigger.activator, closest, false)
		SendToConsole("dota_camera_center")
	end
end
for i, hero in pairs(_G.DualArenavs1) do
	if trigger.activator == hero and arena:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(_G.DualTeleportTargetMana)
		FindClearSpaceForUnit(trigger.activator, closest, false)
		SendToConsole("dota_camera_center")
	end
end
for i, hero in pairs(_G.DualArena2) do
	if trigger.activator == hero and arena2:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(_G.DualTeleportTargetMana)
		FindClearSpaceForUnit(trigger.activator, closest, false)
		SendToConsole("dota_camera_center")
	end
end
for i, hero in pairs(_G.DualArenavs2) do
	if trigger.activator == hero and arena2:IsTouching(hero) == true then
	else
		trigger.activator:SetMana(_G.DualTeleportTargetMana)
		FindClearSpaceForUnit(trigger.activator, closest, false)
		SendToConsole("dota_camera_center")
	end
end
end

