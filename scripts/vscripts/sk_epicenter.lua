function Splash(keys)
local caster = keys.caster
local cability = keys.ability
local targets = FindUnitsInRadius(4, caster:GetAbsOrigin(), nil, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE+DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
for x=1,8 do
for _,target in pairs(targets) do
	local position = RandomVector(200)
	local slocation = target:GetAbsOrigin() + position
	print(slocation)
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_sandking/sandking_epicenter_tell_low.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(effectIndex,0,slocation)
	ParticleManager:SetParticleControl(effectIndex,1,slocation)
	ParticleManager:SetParticleControl(effectIndex,2,slocation)
	ParticleManager:SetParticleControl(effectIndex,3,slocation)
	print("Set epicenter particles")
	local e = FindUnitsInRadius(4, slocation, nil, 300, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE+DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
		for _,ent in pairs(e) do
			if ent:IsRealHero() == true then
				local dtable = {victim = ent, attacker = caster, damage = cability:GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL, ability = cability}
				ApplyDamage(dtable)
				print("applied damage for epicenter")
			end
		end
		x = x + 1
	end
end
end