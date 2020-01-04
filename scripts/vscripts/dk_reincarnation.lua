function ResetDK(keys)
local caster = keys.caster
caster:Kill(nil, nil)
CreateUnitByName("npc_boss_dragon_knight_1", caster:GetAbsOrigin(), true, nil, nil, 4)
end

function TransformDK(keys)
local caster = keys.caster
CreateUnitByName("npc_boss_dragon_knight_2", caster:GetAbsOrigin(), true, nil, nil, 4)
end

local dk = Entities:FindAllByClassname("npc_dota_creature")
	for _, boss in ipairs(dk) do
		if boss:GetUnitName() == "npc_boss_dragon_knight_2" then
			ApplyDataDrivenModifier(boss, boss, "modifier_reset", {duration=180})
		end
	end
end