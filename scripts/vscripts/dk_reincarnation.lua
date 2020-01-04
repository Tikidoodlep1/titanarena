function ResetDK(keys)
local caster = keys.caster
if caster:IsAlive() == true then
caster:Kill(nil, nil)
CreateUnitByName("npc_boss_dragon_knight_1", caster:GetAbsOrigin(), true, nil, nil, 4)
end
end

function TransformDK(keys)
local caster = keys.caster
CreateUnitByName("npc_boss_dragon_knight_2", caster:GetAbsOrigin(), true, nil, nil, 4)
end