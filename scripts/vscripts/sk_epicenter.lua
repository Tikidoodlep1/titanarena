function Splash(keys)
local x = 0
Timers:CreateTimer(0, function()
local caster = keys.caster
local cability = keys.ability
local team = caster:GetTeamNumber()
local ability_damage = cability:GetSpecialValueFor("damage")
print("casters team number is "..team)
local targets = FindUnitsInRadius(2,caster:GetAbsOrigin(),nil,800,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_NIGHTMARED,FIND_ANY_ORDER,false)
for _,target in pairs(targets) do
	local position = RandomVector(150)
	local slocation = target:GetAbsOrigin() + position
	print(slocation)
	local effectIndex = ParticleManager:CreateParticle("particles/econ/items/sand_king/sandking_barren_crown/sandking_rubyspire_burrowstrike.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(effectIndex,0,slocation)
	ParticleManager:SetParticleControl(effectIndex,1,slocation)
	print("Set epicenter particles")
	local e = FindUnitsInRadius(2,slocation,nil,200,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_NIGHTMARED,FIND_ANY_ORDER,false)
		for _,ent in pairs(e) do
			if ent:GetUnitName() ~= "npc_boss_scarab" then
				local dtable = {victim = ent, attacker = caster, damage = 150, damage_type = DAMAGE_TYPE_MAGICAL, ability = cability}
				ApplyDamage(dtable)
				print("applied damage for epicenter")
			end
		end
	end
	x = x + 1
	print("x = "..x)
	if x<8 then
	return 1
	end
end)
end