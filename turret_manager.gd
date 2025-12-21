extends Node3D
class_name TurretManager

# Exported variables
@export var turret: PackedScene
@export var path: Path3D

# Public methods
func build_turret(turret_position: Vector3) -> void:
	var new_turret = turret.instantiate()
	add_child(new_turret)
	new_turret.global_position = turret_position
	new_turret.path = path
