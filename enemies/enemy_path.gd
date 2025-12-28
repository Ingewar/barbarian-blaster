extends Path3D

@export var enemy : PackedScene

@onready var spawn_timer: Timer = $SpawnTimer

func spawn_enemy() -> void:
	var enemy_instance = enemy.instantiate()
	add_child(enemy_instance)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
