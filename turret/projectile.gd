extends Area3D

# Exported variables
@export var speed := 30.0
@export var damage := 1

# Public variables
var direction := Vector3.FORWARD

# Onready variables
@onready var destroy_timer: Timer = %DestroyTimer

# Built-in methods
func _physics_process(delta: float) -> void:
	position += direction * speed * delta

# Signal callbacks
func _on_destroy_timer_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().health -= damage
		queue_free()