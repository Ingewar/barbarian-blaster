extends MarginContainer

@export var start_gold := 20

var gold : int:
    set(gold_in):
        gold = max(gold_in, 0)
        $GoldLabel.text = "Gold: %d" % gold
    get:
        return gold

@onready var gold_label = $GoldLabel

func _ready() -> void:
    gold = start_gold