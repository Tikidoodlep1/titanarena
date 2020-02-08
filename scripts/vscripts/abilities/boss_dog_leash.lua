dog_leash = class({})

-----------------------------------------------------------------------------

function dog_leash:ProcsMagicStick()
	return false
end

-----------------------------------------------------------------------------

function dog_leash:GetCooldown( iLevel )
	return self.BaseClass.GetCooldown( self, self:GetLevel() ) / self:GetCaster():GetHasteFactor() 
end

-----------------------------------------------------------------------------

function dog_leash:OnSpellStart()
	EmitSoundOn("Hero_Magnataur.Skewer.Cast", self:GetCaster())
	local dist = (thisEntity:GetOrigin() - self.vInitialSpawnPos):Length2D
	self:SetBaseMoveSpeed(400)
	local heroes = FindUnitsInRadius(4, self:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
	self:MoveToPosition(heroes[0]:GetAbsOrigin())
	self:AddNewModifier(self, "boss_dog_leash", "modifier_phased", {duration=1})
	Timers:CreateTimer(0, function()
		if dist >= 600 then
			self:AddNewModifier(self, "boss_dog_leash", "modifier_stunned", {duration=4})
			self:SetBaseMoveSpeed(320)
			Timers:CreateTimer(4, function()
				self:MoveToPosition(self.vInitialSpawnPos)
			end)
			Timers.removeSelf = true
		elseif thisEntity:GetAbsOrigin() - heroes[0]:GetAbsOrigin() == thisEntity:GetAbsOrigin() then
			local damageTable = {victim = heroes[0], attacker = self, damage = 300, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self:FindAbilityByName("boss_dog_leash")}
			ApplyDamage(damageTable)
			self:SetBaseMoveSpeed(320)
			self:MoveToPositionAggressive(heroes[0]:GetAbsOrigin)
			heroes[0]:AddNewModifier(self, "boss_dog_leash", "modifier_stunned", {duration=2})
			Timers.removeSelf = true
		end
		return 0.3
	end)
end

-----------------------------------------------------------------------------

function TouchingHero(caster)
	Timers:CreateTimer(0, function()
		touched = FindUnitsInRadius(4, caster:GetAbsOrigin(), nil, 100, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
		if touched then
			for _, hero in pairs(touched) do
				hero:AddNewModifier(self, "boss_dog_leash", "modifier_stunned", {duration=1.5})
			end
		end
		return 0.2
	end)
end