extends ModeRoot
class_name Gameroot

@onready var board:Node = $nde2_Board

var deckSize:int
var remainingDraws:int = deckSize
var playerHealth:int = 20
var roomNumber:int = 0

func _init() -> void:
	Instance = self

func _enter_tree() -> void:
	OilBoard.set_oil_transition()

func _physics_process(_delta: float) -> void:
	$cvl_Game_UI/ctr2_Game_UI/lbl2_Dungeon.text = "Room: %s \nDeck: %s" % [roomNumber, remainingDraws]
	$cvl_Game_UI/ctr2_Game_UI/lbl2_Health.text = "HP: %s" % playerHealth

func _clear_board() -> void:
	for item:Node2D in board.get_children():
		item.queue_free()
