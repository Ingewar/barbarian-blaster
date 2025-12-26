extends Node3D

# Exported variables
@export var projectile: PackedScene
@export var turret_range := 10.0

# Public variables
var path: Path3D
var target: PathFollow3D

# Onready variables
@onready var shot_timer: Timer = $ShotTimer
@onready var projectile_spawn_point: Marker3D = %projectile_spawn_point

# Built-in methods
func _physics_process(_delta: float) -> void:
	target = find_best_target()
	if target:
		look_at(target.global_position)

# Signal callbacks
func _on_shot_timer_timeout() -> void:
	if target == null: 
		return
	var shot := projectile.instantiate() as Node3D
	get_tree().root.add_child(shot)
	shot.global_position = projectile_spawn_point.global_position
	shot.direction = -global_transform.basis.z

func find_best_target() -> PathFollow3D:
	var enemies = path.get_tree().get_nodes_in_group("enemy")
	if enemies.size() <= 0:
		return null

	# First, filter enemies by distance (within turret range)
	var enemies_in_range: Array = [PathFollow3D]
	for enemy in enemies:
		if enemy is PathFollow3D:
			var distance := global_position.distance_to(enemy.global_position)
			if distance <= turret_range:
				enemies_in_range.append(enemy)

	if enemies_in_range.size() <= 0:
		return null

	# Then, choose the enemy with the biggest progress_ratio
	var best_target: PathFollow3D = null
	var best_progress := 0.0
	for enemy in enemies_in_range:
		if enemy.progress_ratio > best_progress:
			best_progress = enemy.progress_ratio
			best_target = enemy

	return best_target