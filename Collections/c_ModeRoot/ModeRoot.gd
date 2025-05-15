extends Node2D
class_name ModeRoot

static var Instance:ModeRoot

func _init() -> void:
	Instance = self

func _enter_tree() -> void:
	OilBoard.set_oil_transition()
