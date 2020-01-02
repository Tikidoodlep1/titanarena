function modifier_apply_natures_attunement_stacks(keys)
local trees_alive = 0
local trees_dead = 0
local target = keys.target
local caster = keys.caster
local damage_stacks = caster:GetModifierStackCount("modifier_natures_attunement_damage_stack", caster)
local armor_stacks = caster:GetModifierStackCount("modifier_natures_attunement_armor_stack", caster)
local basedamage = caster:GetBaseDamageMax()
local ability = keys.ability
local trees = GridNav:GetAllTreesAroundPoint(caster:GetAbsOrigin(), 1000, true)

	for _,entity in pairs(trees) do
		if entity:IsStanding() == true then 
			trees_alive = trees_alive + 1
		end
		trees_dead = 75 - trees_alive
		if trees_dead <= 0 then
			trees_dead = 0
		end
		if trees_alive >= 75 then
			trees_alive = 75
		end
	end
caster:SetModifierStackCount("modifier_natures_attunement_damage_stack", caster, trees_alive)
caster:SetModifierStackCount("modifier_natures_attunement_armor_stack", caster, trees_dead)
end