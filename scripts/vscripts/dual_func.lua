function OutOfDuals(trigger)

local point = Entities:FindByName(nil, trigger.caller:GetName()):GetAbsOrigin()
local playerloc = trigger.activator:GetAbsOrigin()
local closest = Entities:FindByNameNearest("dual_keepout", playerloc, 10000):GetAbsOrigin()

trigger.activator:Stop()
trigger.activator:Interrupt()
FindClearSpaceForUnit(trigger.activator, closest, false)
SendToConsole("dota_camera_center")

end