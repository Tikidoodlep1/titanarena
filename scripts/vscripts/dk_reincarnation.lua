function ResetDK(keys)
local caster = keys.caster
caster:Kill(nil, nil)
CreateUnitByName("npc_boss_dragon_knight_1", caster:GetAbsOrigin(), true, nil, nil, 4)
end

function TransformDK(keys)
local caster = keys.caster
CreateUnitByName("npc_boss_dragon_knight_2", caster:GetAbsOrigin(), true, nil, nil, 4)
Timers:CreateTimer(1, function()
local units = Entities:FindAllByClassname("npc_dota_creature")
for _, dk in pairs(units) do
if dk:GetUnitName() == "npc_boss_dragon_knight_2" then
ApplyDataDrivenModifier(dk, dk, "modifier_fireball", {duration=-1})
ApplyDataDrivenModifier(dk, dk, "modifier_reset", {duration=180})
end
break
end
end)
end