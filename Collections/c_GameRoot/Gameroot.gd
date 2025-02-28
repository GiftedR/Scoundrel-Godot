extends Node2D
class_name Gameroot

static var Instance:Gameroot

func _init() -> void:
	Instance = self

func _enter_tree() -> void:
	OilBoard.set_oil_transition()