class_name ProjectileCalculator

## Calculates stats for a projectile instance based on the current WeaponLevel and CharacterSheet values
## for the weapon and character using the weapon
static func calculate_stats(p_weapon_level : WeaponLevel, p_character_sheet : CharacterSheet) -> ProjectileStats:
	var stats := ProjectileStats.new()
	stats.power_min = p_weapon_level.min_power * p_character_sheet.get_power_multiplier()
	stats.power_max = p_weapon_level.max_power * p_character_sheet.get_power_multiplier()
	stats.speed = p_weapon_level.speed * p_character_sheet.get_weapon_speed_multiplier()
	return stats
