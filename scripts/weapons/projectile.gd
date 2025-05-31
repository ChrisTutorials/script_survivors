class_name Projectile
extends Node2D

@export var hit_boxes : Array[HitBox2D]

## Direction the projectile is moving
var direction : Vector2

## Runtime stats for this instance of the weapon projectile
var stats : ProjectileStats

var _launched := false
var _random := RandomNumberGenerator.new()

func _ready():
	assert(not hit_boxes.is_empty(), "Must set a hitbox on the %s" % self)
	
	for hit_box in hit_boxes:
		hit_box.hurt_box_hit.connect(_on_hit)

## Starts moving the projectile in the direction parameter
func launch(p_direction : Vector2, p_stats : ProjectileStats) -> void:
	direction = p_direction
	stats = p_stats
	_launched = true
	
## Returns the base calculated damage for the weapon instance
## Randomizes between power_min and power_max
func calculate_damage() -> float:
	var min := stats.power_min
	var max := stats.power_max
	var randomed := _random.randi_range(min, max)
	return randomed

func _process(delta: float) -> void:
	if not _launched:
		return
	
	var change := direction * stats.speed * delta
	self.translate(change)

func _on_hit(p_box : HurtBox2D):
	p_box.hit(self)
