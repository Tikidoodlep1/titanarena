function Splash(keys)
local caster = keys.caster
local cability = keys.ability
local radius = cability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)
local targets = Entities:FindInSphere(nil, caster:GetAbsOrigin(), radius)

for _,target in pairs(targets) do
	local position = RandomVector(radius/2)
	local slocation = __add(caster:GetAbsOrigin(), position)
	local effectIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_sandking/sandking_epicenter_tell_low.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(effectIndex,0,slocation)
	ParticleManager:SetParticleControl(effectIndex,1,slocation)
	ParticleManager:SetParticleControl(effectIndex,2,slocation)
	ParticleManager:SetParticleControl(effectIndex,3,slocation)
	local e = Entities:FindInSphere(nil, slocation, 300)
	for _,ent in pairs(e) do
		if ent:IsRealHero == true then
		local dtable = {victim = ent, attacker = caster, damage = cability:GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL, ability = cability}
		ApplyDamage(dtable)
		end
	end
end