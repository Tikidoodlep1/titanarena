if modifier_titan_slain == nil then
	modifier_titan_slain = class({})
end

function modifier_titan_slain:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_TOOLTIP,
    }
    return funcs
end

function modifier_titan_slain:IsHidden()
	return true
end

function modifier_titan_slain:IsBuff()
	return true
end

function modifier_titan_slain:Duration()
	return 600
end

function modifier_titan_slain:TextureName()
	return "titan_slain_buff"
end

function modifier_titan_slain:OnTooltip(keys)
	local parent = self:GetParent()
	local net_worth = parent:GetTotalEarnedGold(parent:GetPlayerID())
	local gpm = parent:GetGoldPerMin(parent:GetPlayerID())
	parent:SetGoldPerTick(net_worth/100 + 1)
	Timers:CreateTimer(600, function()
	parent:SetGoldPerTick(gpm)
	end)
	return "Gaining Bonus Gold Per Minute, Along With Increased Invader Strength!"
end
