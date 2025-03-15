extends Node2D
class_name Gameroot

static var Instance:Gameroot
@onready var board:Node = $nde2_Board

func _init() -> void:
	Instance = self

func _enter_tree() -> void:
	OilBoard.set_oil_transition()

func _clear_board() -> void:
	for item:Node2D in board.get_children():
		item.queue_free()
