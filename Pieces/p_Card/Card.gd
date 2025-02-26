extends Area2D
class_name Card

@export var rotScale:Vector2 = Vector2(2,2)

static func create() -> Card:
	return load("res://Pieces/p_Card.tscn").instantiate()

func _enter_tree() -> void:
	mouse_entered.connect(func() -> void:
		$asp2_Card_Outline.visible = true
	)
	
	mouse_exited.connect(func() -> void:
		$asp2_Card_Outline.visible = false
	)

static var lastMessage:String = ""
static func distinct_print(message:Array) -> void:
	if str(message) != lastMessage:
		print(message)
		lastMessage = str(message)
