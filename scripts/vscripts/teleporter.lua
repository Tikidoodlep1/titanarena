TELEPORTERS = {trigger_teleporter2 = "teleporter_exit1", trigger_teleporter3 = "teleporter_exit"}

function teleport3(trigger)
local point = Entities:FindByName(nil, TELEPORTERS[trigger.caller:GetName()]):GetAbsOrigin()
FindClearSpaceForUnit(trigger.activator, point, false)
SendToConsole("dota_camera_center")
end

function teleport2(trigger)
local point = Entities:FindByName(nil, TELEPORTERS[trigger.caller:GetName()]):GetAbsOrigin()
FindClearSpaceForUnit(trigger.activator, point, false)
SendToConsole("dota_camera_center")
end

