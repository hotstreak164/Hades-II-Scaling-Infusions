---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- this file will be reloaded if it changes during gameplay,
-- 	so only assign to values or define things here.


-- These functions are part of the example code snippets from ready.lua
-- function sjson_ShellText(data)
-- 	for _,v in ipairs(data.Texts) do
-- 		if v.Id == 'MainMenuScreen_PlayGame' then
-- 			v.DisplayName = 'Test ' .. _PLUGIN.guid
-- 			break
-- 		end
-- 	end
-- end

-- function prefix_SetupMap()
-- 	print('Map is loading, here we might load some packages.')
-- 	-- LoadPackages({Name = package_name_string})
-- end

function sjson_TraitText_AirQuality(data)
	for _,v in ipairs(data.Texts) do
		if v.Id == 'ElementalDamageFloorBoon' then
			v.Description = 'Damage limit increases for each {!Icons.CurseAir} you have, you can never deal less damage than the limit.'
			break
		end
	end
end

function sjson_TraitText_SelfHealing(data)
	for _,v in ipairs(data.Texts) do
		if v.Id == 'ElementalRallyBoon' then
			v.Description = 'For each {!Icons.CurseFire} you have, whenever you take damage, restore some {!Icons.Health}.'
			break
		end
	end
end

function sjson_TraitText_FrostyVeneer(data)
	for _,v in ipairs(data.Texts) do
		if v.Id == 'ElementalDamageCapBoon' then
			v.Description = 'For each {!Icons.CurseWater} you have, whenever you would take at least {$TraitData.ElementalDamageCapBoon.ActivatedDamageReductionThreshold} damage, take less.'
			break
		end
	end
end

function sjson_TraitText_RallyingCry(data)
	for _,v in ipairs(data.Texts) do
		if v.Id == 'ElementalOlympianDamageBoon' then
			v.Description = 'Your damaging effects from Olympians are stronger for each {!Icons.CurseEarth} you have.'
			break
		end
	end
end
