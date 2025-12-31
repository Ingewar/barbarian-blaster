extends Node

class_name DifficultyManager

signal wave_completed

@export var wave_time := 30.0
@export var spawn_time_curve: Curve

@onready var timer: Timer = $Timer

func _ready() -> void:
    timer.wait_time = wave_time
    timer.start()
    timer.timeout.connect(func () -> void: wave_completed.emit())

func get_wave_progress_ratio() -> float:
    return 1.0 - (timer.time_left / wave_time)

func get_spawn_time() -> float:
    return spawn_time_curve.sample(get_wave_progress_ratio())