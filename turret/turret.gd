extends Node3D

# Exported variables
@export var projectile: PackedScene

# Public variables
var path: Path3D

# Onready variables
@onready var shot_timer: Timer = $ShotTimer
@onready var projectile_spawn_point: Marker3D = %projectile_spawn_point

# Built-in methods
func _physics_process(_delta: float) -> void:
	var enemy = path.get_tree().get_first_node_in_group("enemy")
	if enemy != null:
		look_at(enemy.global_position)

# Signal callbacks
func _on_shot_timer_timeout() -> void:
	var shot := projectile.instantiate() as Node3D
	get_tree().root.add_child(shot)
	shot.global_position = projectile_spawn_point.global_position
	shot.direction = -global_transform.basis.z
