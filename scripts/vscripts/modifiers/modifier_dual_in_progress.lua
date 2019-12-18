if modifier_dual_in_progress == nil then
	modifier_dual_in_progress = class({})
end

function modifier_dual_in_progress:IsHidden()
    return true
end

function modifier_dual_in_progress:IsPurgable()
    return false
end

function modifier_dual_in_progress:DeclareFunctions()
	local funcs = {
	}

	return funcs
end

function modifier_custom_invulnerable:CheckState() 
  local state = {
  }
  return state
end