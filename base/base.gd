extends Node3D

# Exported variables
@export var max_health := 5

@export_category("Label Colors")
@export var high_health_text_color := Color.WHITE
@export var low_health_text_color := Color.RED

# Public variables
var current_health: int:
	set(health):
		current_health = health
		health_label.text = str(current_health) + "/" + str(max_health)
		health_label.modulate = low_health_text_color.lerp(high_health_text_color, float(current_health) / float(max_health))
		if current_health <= 0:
			get_tree().reload_current_scene()

# Onready variables
@onready var health_label: Label3D = $health_label

# Built-in methods
func _ready() -> void:
	current_health = max_health

# Public methods
func take_damage(damage: int) -> void:
	current_health -= damage
