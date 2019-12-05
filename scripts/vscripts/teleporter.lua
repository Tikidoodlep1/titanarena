TELEPORTERS = {trigger_teleporter = "teleporter_exit", trigger_teleporter2 = "teleporter_exit1"}

function teleport(trigger)
local point = Entities:FindByName(nil, TELEPORTERS[trigger.caller:GetName()]):GetAbsOrigin()
FindClearSpaceForUnit(trigger.activator, point, false)
trigger.activarot:stop()
SendToConsole("dota_camera_center")
end

function teleport2(trigger)
local point = Entities:FindByName(nil, TELEPORTERS[trigger.caller:GetName()]):GetAbsOrigin()
FindClearSpaceForUnit(trigger.activator, point, false)
trigger.activarot:stop()
SendToConsole("dota_camera_center")
end