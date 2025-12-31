extends Path3D

@export var enemy : PackedScene
@export var difficulty_manager: DifficultyManager

@onready var spawn_timer: Timer = $SpawnTimer

func spawn_enemy() -> void:
	var enemy_instance = enemy.instantiate()
	add_child(enemy_instance)

func _on_spawn_timer_timeout() -> void:
	var spawn_time = difficulty_manager.get_spawn_time()
	spawn_timer.wait_time = spawn_time
	spawn_enemy()
