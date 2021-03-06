function item_blink_datadriven_on_spell_start(keys)
	ProjectileManager:ProjectileDodge(keys.caster)  --Disjoints disjointable incoming projectiles.
	
	ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, keys.caster)
	keys.caster:EmitSound("DOTA_Item.BlinkDagger.Activate")
	
	local origin_point = keys.caster:GetAbsOrigin()
	local target_point = keys.target_points[1]
	local difference_vector = target_point - origin_point
	local caster = keys.caster
	local ability = keys.ability
	local stun_duration = ability:GetSpecialValueFor("stun_duration")
	local stun_range = ability:GetSpecialValueFor("stun_range")
	
	if difference_vector:Length2D() > keys.MaxBlinkRange then  --Clamp the target point to the BlinkRangeClamp range in the same direction.
		target_point = origin_point + (target_point - origin_point):Normalized() * keys.BlinkRangeClamp
	end
	
	keys.caster:SetAbsOrigin(target_point)
	FindClearSpaceForUnit(keys.caster, target_point, false)
	
	ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, keys.caster)
	local units = FindUnitsInRadius(caster:GetTeamNumber(), target_point, nil, stun_range , DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
	for number,entity in pairs(units) do
			if entity:IsHero() then
				print(entity)
							ability:ApplyDataDrivenModifier(caster, entity, "modifier_stunning_blink_stun", {duration = stun_duration})
							ParticleManager:CreateParticle("particles/abyssal_blink_stun.vpcf", PATTACH_ABSORIGIN_FOLLOW, entity)
				return
			end
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	Called when a unit with Blink Dagger in their inventory takes damage.  Puts the Blink Dagger on a brief cooldown
	if the damage is nonzero (after reductions) and originated from any player or Roshan.
	Additional parameters: keys.BlinkDamageCooldown and keys.Damage
	Known Bugs: keys.Damage contains the damage before reductions, whereas we want to compare the damage to 0 after reductions.
================================================================================================================= ]]
function modifier_item_blink_datadriven_damage_cooldown_on_take_damage(keys)
	local attacker_name = keys.attacker:GetName()

	if keys.Damage > 0 and (attacker_name == "npc_dota_roshan" or keys.attacker:IsControllableByAnyPlayer()) or keys.attacker:IsBoss() == true then  --If the damage was dealt by neutrals or lane creeps, essentially.
		if keys.ability:GetCooldownTimeRemaining() < keys.BlinkDamageCooldown then
			keys.ability:StartCooldown(keys.BlinkDamageCooldown)

		end
	end
end

function Block(keys)
local chance = RandomInt(0, 1)
local caster = keys.caster
	if caster:IsRangedAttacker() == true then
		local ranged = true
	else
		local ranged = false
	end
	if chance == 1 then
		if ranged == true then
			keys.ability:ApplyDataDrivenModifier(caster, caster, "modifier_block_ranged", {duration=0.5})
		else
			keys.ability:ApplyDataDrivenModifier(caster, caster, "modifier_block_melee", {duration=0.5})
		end
	end
end

function OnCD(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability
local chance = RandomInt(0, 100)
	if chance <= 25 and ability:GetCooldownTimeRemaining() == 0 then
	local damagetable = {
		victim = target,
		attacker = caster,
		damage = 100,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		}
	ApplyDamage(damagetable)
	ability:ApplyDataDrivenModifier(caster, target, "modifier_stunning_blink_stun", {duration=2})
	ability:StartCooldown(5)
	end
end