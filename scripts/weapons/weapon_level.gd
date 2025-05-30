## Defines statistics for a single weapon level
class_name WeaponLevel
extends Resource

## In game spell object. Only required to define for first level and levels where it changes.
@export_file("*.tscn") var scene_path : String

## Graphic to show for UI. Only required to define for first level and levels where it changes.
@export var icon : Texture2D

## Minimum base effect this weapon can do
@export_range(0, 100, 1, "or_greater") var min_power : int = 1

## Maximum base effect the weapon can do
@export_range(0, 100, 1, "or_greater") var max_power : int = 10

## Number of hits each projectile can do. 0 is considered infinite.
@export_range(0, 100, 1, "or_greater") var max_hits : int = 1

## Base speed of the weapon at this level
@export var speed : float = 0.0

## Base cooldown between weapon casts
@export_range(0.01, 100, 0.01, "or_greater") var cooldown : float = 1.0

## Maximum duration for effects instanced
@export_range(0.01, 100, 0.01, "or_greater") var duration : float = 5.0

## Number of projectiles to spawn per cast
@export_range(0, 100, 1, "or_greater")  var projectiles : int = 1
