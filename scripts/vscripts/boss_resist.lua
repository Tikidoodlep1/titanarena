function resist(keys)
keys.caster:AddNewModifier(caster, nil, "modifier_status_resistance", {duration=-1})

if keys.caster:HasModifier("modifier_status_resistance") == true then
print("Modifier Applied")
else
print("Modifier Not Found")
end
end