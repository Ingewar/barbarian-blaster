extends PathFollow3D

# Signals
signal health_changed(health: int)

# Exported variables
@export var speed := 1.0
@export var damage := 1
@export var max_health := 2

# Public variables
var health := max_health:
	set(value):
		health = value
		health_changed.emit(health)
		if health <= 0:
			die()

# Onready variables
@onready var base = get_tree().get_first_node_in_group("base")

# Built-in methods
func _process(delta: float) -> void:
	progress += delta * speed

	if progress_ratio == 1.0:
		base.take_damage(damage)
		queue_free()

# Public methods
func die() -> void:
	queue_free()



func _on_damage_taken(damage_value: int) -> void:
	health -= damage_value
