function FireProj(keys)
local caster = keys.caster
local target = keys.target
local effectIndex = ParticleManager:CreateParticle("particles/dk_fireball.vpcf", PATTACH_CUSTOMORIGIN, target)
ParticleManager:SetParticleControl(effectIndex,0,target:GetAbsOrigin())
ParticleManager:SetParticleControl(effectIndex,1,target:GetAbsOrigin())
ParticleManager:SetParticleControl(effectIndex,3,target:GetAbsOrigin())
ParticleManager:SetParticleControl(effectIndex,4,target:GetAbsOrigin())
ParticleManager:SetParticleControl(effectIndex,5,target:GetAbsOrigin() + Vector(0, -100, 0))
ParticleManager:SetParticleControl(effectIndex,6,target:GetAbsOrigin() + Vector(100, 0, 0))
ParticleManager:SetParticleControl(effectIndex,7,target:GetAbsOrigin() + Vector(0, 100, 0))
ParticleManager:SetParticleControl(effectIndex,8,target:GetAbsOrigin() + Vector(-100, 0, 0))
Timers:CreateTimer(1, function()
local pos1 = Vector(200, 0, 0)
local pos2 = Vector(-200, 0, 0)
local pos3 = Vector(0, 200, 0)
local pos4 = Vector(0, -200, 0)
local pos = target:GetAbsOrigin() + pos1
local hits = FindUnitsInRadius(2, pos, nil, 150, 3, 63, 0, 0, false)
for _, targets in ipairs(hits) do
local damagetable = {victim = targets,
	attacker = caster,
	damage = (caster:GetAttackDamage()/2),
	damage_type = DAMAGE_TYPE_PHYSICAL,}
ApplyDamage(damagetable)
end
pos = target:GetAbsOrigin() + pos2
hits = FindUnitsInRadius(2, pos, nil, 150, 3, 63, 0, 0, false)
for _, targets in ipairs(hits) do
local damagetable = {victim = targets,
	attacker = caster,
	damage = (caster:GetAttackDamage()/2),
	damage_type = DAMAGE_TYPE_PHYSICAL,}
ApplyDamage(damagetable)
end
pos = target:GetAbsOrigin() + pos3
hits = FindUnitsInRadius(2, pos, nil, 150, 3, 63, 0, 0, false)
for _, targets in ipairs(hits) do
local damagetable = {victim = targets,
	attacker = caster,
	damage = (caster:GetAttackDamage()/2),
	damage_type = DAMAGE_TYPE_PHYSICAL,}
ApplyDamage(damagetable)
end
pos = target:GetAbsOrigin() + pos4
hits = FindUnitsInRadius(2, pos, nil, 150, 3, 63, 0, 0, false)
for _, targets in ipairs(hits) do
local damagetable = {victim = targets,
	attacker = caster,
	damage = (caster:GetAttackDamage()/2),
	damage_type = DAMAGE_TYPE_PHYSICAL,}
ApplyDamage(damagetable)
end
ParticleManager:DestroyParticle(effectIndex, true)
end)
end