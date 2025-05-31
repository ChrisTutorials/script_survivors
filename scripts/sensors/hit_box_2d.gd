## Detects when it comes into contact with a hurtbox and emits hurt_box_hit signal
class_name HitBox2D
extends Area2D

signal hurt_box_hit(box : HurtBox2D)

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(p_area : Area2D):
	if p_area is HurtBox2D:
		hurt_box_hit.emit(p_area)
