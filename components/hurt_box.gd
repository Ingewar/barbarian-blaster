extends Area3D

class_name HurtBox

signal damage_taken(damage: int)

func take_damage(damage: int) -> void:
    damage_taken.emit(damage)