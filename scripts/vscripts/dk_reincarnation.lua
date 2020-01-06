function ResetDK(keys)
local caster = keys.caster
print("Ran ResetDK")
caster:Kill(nil, nil)
local levels = GetGameTime()/10
CreateUnitByName("npc_boss_dragon_knight_1", caster:GetAbsOrigin(), true, nil, nil, 4):CreatureLevelUp(levels)
end

function TransformDK(keys)
local caster = keys.caster
CreateUnitByName("npc_boss_dragon_knight_2", caster:GetAbsOrigin(), true, nil, nil, 4)
end