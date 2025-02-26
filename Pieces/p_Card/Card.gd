extends Area2D
class_name Card

static func create() -> Card:
	return load("res://Pieces/p_Card.tscn").instantiate()

@export var rank:int = 1

@onready var _outline: AnimatedSprite2D = $asp2_Card_Outline

func _enter_tree() -> void:
	mouse_entered.connect(func() -> void:
		_outline.visible = true
	)
	
	mouse_exited.connect(func() -> void:
		_outline.visible = false
	)

func _ready() -> void:
	_outline.visible = false
