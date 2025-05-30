## Defines statistics for a single weapon level
class_name WeaponLevel
extends Resource

## In game combat sprite for animations. Only required to define for first level and levels where it changes.
@export var sprite : Texture2D

## Graphic to show for UI. Only required to define for first level and levels where it changes.
@export var icon : Texture2D

## Minimum base effect this weapon can do
@export_range(0, 100, 1, "or_greater") var min_power : int = 1

## Maximum base effect the weapon can do
@export_range(0, 100, 1, "or_greater") var max_power : int = 10

@export_range(0, 100, 1, "or_greater")  var projectiles : int = 1
