function Splash(keys)
local x = 0
Timers:CreateTimer(0, function()
local caster = keys.caster
local cability = keys.ability
local team = caster:GetTeamNumber()
local targets = FindUnitsInRadius(team, caster:GetAbsOrigin(), nil, 800, 3, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE+DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
for _,target in pairs(targets) do
	local position = RandomVector(150)
	local slocation = target:GetAbsOrigin() + position
	print(slocation)
	local effectIndex = ParticleManager:CreateParticle("particles/econ/items/sand_king/sandking_barren_crown/sandking_rubyspire_burrowstrike.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(effectIndex,0,slocation)
	ParticleManager:SetParticleControl(effectIndex,1,slocation)
	print("Set epicenter particles")
	local e = FindUnitsInRadius(team, slocation, nil, 200, 3, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE+DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
		for _,ent in pairs(e) do
			if ent:IsRealHero() == true then
				local dtable = {victim = ent, attacker = caster, damage = 175, damage_type = DAMAGE_TYPE_MAGICAL, ability = cability}
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