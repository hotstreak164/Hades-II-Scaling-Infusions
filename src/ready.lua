---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- here is where your mod sets up all the things it will do.
-- this file will not be reloaded if it changes during gameplay
-- 	so you will most likely want to have it reference
--	values and functions later defined in `reload.lua`.

-- These are some sample code snippets of what you can do with our modding framework:
local file = rom.path.combine(rom.paths.Content, 'Game/Text/en/ShellText.en.sjson')
sjson.hook(file, function(data)
	return sjson_ShellText(data)
end)

modutil.mod.Path.Wrap("SetupMap", function(base, ...)
	prefix_SetupMap()
	return base(...)
end)

-- Rallying Cry: ElementalOlympianDamageBoon
local olympianDmg =
{
	ElementalOlympianDamageBoon =
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Ares_40",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Earth" },
				Comparison = ">=",
				Value = 4,
			},
		},
		ElementalMultipliers =
		{
			Earth = true,
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		AddOutgoingDamageModifiersArray =
		{
			{
				ValidProjectiles = WeaponSets.OlympianProjectileNames,
				ValidWeaponMultiplier =
				{
					BaseValue = 1.0625,
					SourceIsMultiplier = true,
					MultipliedByElement = "Earth",
					IdenticalMultiplier =
					{
						Value = DuplicateMultiplier,
					},
				},
				ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier"}
			},
			{
				ValidEffects = WeaponSets.OlympianEffectNames,
				ValidWeaponMultiplier =
				{
					BaseValue = 1.0625,
					SourceIsMultiplier = true,
					MultipliedByElement = "Earth",
					IdenticalMultiplier =
					{
						Value = DuplicateMultiplier,
					},
				}
			}
		},
		StatLines =
		{
			"EarthOlympianDamageStatDisplay1"
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				Format = "PercentDelta",
			},
		}
	},
}


-- Self Healing: ElementalRallyBoon
local Rally =
{
	ElementalRallyBoon =
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Apollo_34",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Fire" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ElementalMultipliers =
		{
			Fire = true,
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		
		OnSelfDamagedFunction = 
		{
			Name = "FireRallyHeal",
			FunctionArgs = 
			{
				Duration = 5,
				Multiplier =
				{
					BaseValue = 0.1,
					MultipliedByElement = "Fire",
				},
				--[[ IdenticalMultiplier =
				{
					Value = DuplicateWeakMultiplier,
				},]]
				ReportValues = { ReportedMultiplier = "Multiplier", ReportedDuration = "Duration"},
			}
		},
		StatLines =
		{
			"HealOverTimeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipMultiplier",
				Format = "Percent",
				HideSigns = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true
			},
		}
	},
}


local dmgFloor =
{
	ElementalDamageFloorBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Zeus_31",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 3,
			},
		},
		ElementalMultipliers =
		{
			Air = true,
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		ActivatedDamageFloor = 
		{ 
			BaseValue = 10,
			MultipliedByElement = "Air",
			AsInt = true,
			IdenticalMultiplier =
			{
				Value = DuplicateWeakMultiplier,
			},
		},
		StatLines =
		{
			"DamageFloorStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ActivatedDamageFloor",
				ExtractAs = "TooltipFloor",
			},
		}
	},
}

game.OverwriteTableKeys(game.TraitData, olympianDmg)
game.OverwriteTableKeys(game.TraitData, Rally)
game.OverwriteTableKeys(game.TraitData, dmgFloor)

game.SetupRunData()
