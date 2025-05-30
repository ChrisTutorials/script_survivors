class_name Projectile
extends Node2D

@export var hit_boxes : Array[HitBox2D]

## Direction the projectile is moving
var direction : Vector2

## Runtime stats for this instance of the weapon projectile
var stats : ProjectileStats

## Number of times the projectile has hit a target
var hits : int = 0 :
	set(value):
		hits = value
		
		## Remove from scene once hits max exceeded
		if stats.are_hits_limited() && hits >= stats.max_hits:
			queue_free()

var _launched := false
var _random := RandomNumberGenerator.new()

func _ready() -> void:
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
	var min_damage := stats.power_min
	var max_damage := stats.power_max
	var randomed := _random.randi_range(min_damage, max_damage)
	return randomed

func _process(delta: float) -> void:
	if not _launched:
		return
	
	var change := direction * stats.speed * delta
	self.translate(change)

func _on_hit(p_box : HurtBox2D) -> void:
	var success := p_box.try_hit(self)
	
	if success:
		hits += 1
