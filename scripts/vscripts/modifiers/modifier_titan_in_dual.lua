if modifier_titan_in_dual == nil then
	modifier_titan_in_dual = class({})
end

function modifier_titan_in_dual:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    }
    return funcs
end

function modifier_titan_in_dual:IsHidden()
	return false
end

function modifier_titan_in_dual:GetModifierDamageOutgoing_Percentage()
local gametime = GameRules:GetGameTime()
local base = 100000*(gametime^2)
local pct = 0.9*(base^(1/6))
	if pct > 100 then
		pct = 100
	end
	pct = pct - 100
	if _G.IsDual == true then
	return pct
	end
end