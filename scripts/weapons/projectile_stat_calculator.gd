class_name ProjectileCalculator

## Calculates stats for a projectile instance based on the current WeaponLevel and CharacterStatController values
## for the weapon and character using the weapon
static func calculate_stats(p_weapon_level : WeaponLevel, p_character_sheet : CharacterStatController) -> ProjectileStats:
	var stats := ProjectileStats.new()
	stats.power_min = int(p_weapon_level.min_power * p_character_sheet.get_power_multiplier())
	stats.power_max = int(p_weapon_level.max_power * p_character_sheet.get_power_multiplier())
	stats.speed = p_weapon_level.speed * p_character_sheet.get_weapon_speed_multiplier()
	stats.max_hits = p_weapon_level.max_hits
	return stats
