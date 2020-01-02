function Apply(keys)
local caster = keys.caster
local basearmor = (caster:GetLevel() * 5) + 45
local basedamage = (caster:GetLevel() * 100) + 1500
local heroes = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 2000, 2, 1, 0, 0, false)
local armorplaceholder = basearmor
local damageplaceholder = basedamage
for _, hero in ipairs(heroes) do
	armorplaceholder = armorplaceholder + 20
	damageplaceholder = damageplaceholder + 70
	print(armorplaceholder)
end
caster:SetPhysicalArmorBaseValue(armorplaceholder)
caster:SetBaseDamageMax(damageplaceholder)
caster:SetBaseDamageMin(damageplaceholder)
end