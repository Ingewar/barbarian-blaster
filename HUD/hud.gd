extends MarginContainer

class_name HUD

@export var start_gold := 20

@onready var gold_label: Label = $GoldLabel

var gold : int:
    set(gold_in):
        gold = max(gold_in, 0)
        gold_label.text = "Gold: %d" % gold
    get:
        return gold

func _ready() -> void:
    gold = start_gold
    Events.enemy_died.connect(_on_enemy_died)

func _on_enemy_died(score: int) -> void:
    gold += score