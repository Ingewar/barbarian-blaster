extends PathFollow3D

# Exported variables
@export var speed := 5.0
@export var damage := 1
@export var max_health := 2
@export var gold_cost := 1

# Onready variables
@onready var base = get_tree().get_first_node_in_group("base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Public variables
var health := max_health:
	set(value):
		health = value
		if health <= 0:
			die()
	get:
		return health

# Built-in methods
func _process(delta: float) -> void:
	progress += delta * speed

	if progress_ratio == 1.0:
		base.take_damage(damage)
		queue_free()

# Public methods
func die() -> void:
	Events.enemy_died.emit(gold_cost)
	queue_free()

func _on_damage_taken(damage_value: int) -> void:
	health -= damage_value
	animation_player.play("TakeDamage")