extends Area2D
class_name Card

enum CardSuit{
	HEARTS = 0,
	DIAMONDS = 1,
	CLUBS = 2,
	SPADES = 3,
	JOKER = 4
}

static func create(startingposition:Vector2i = Vector2i.ZERO) -> Card:
	return load("res://Pieces/p_Card.tscn").instantiate().set_starting_pos(startingposition)

@export_range(1, 13) var rank:int = 1
@export var suit:CardSuit = CardSuit.HEARTS
@export var targetPosition:Vector2 = Vector2.ZERO

@onready var _outline: AnimatedSprite2D = $asp2_Card_Outline
@onready var _cardbg:Sprite2D = $spe2_Card_Body

var _startingpos:Vector2i = Vector2i.ZERO

func _enter_tree() -> void:
	mouse_entered.connect(func() -> void:
		_outline.visible = true
	)
	
	mouse_exited.connect(func() -> void:
		_outline.visible = false
	)
	
	position = _startingpos

func _ready() -> void:
	_outline.visible = false
	
	#await get_tree().create_timer(randf_range(0, 5)).timeout
	#$anp_Idle.play("Idle")

func _physics_process(delta: float) -> void:
	_set_card_texture(rank, suit)
	if targetPosition != position:
		position = position.slerp(targetPosition, delta * 5)

func _set_card_texture(cardrank:int, cardsuit:CardSuit) -> void:
	if !is_inside_tree():
		return
	_cardbg.frame_coords.x = (cardsuit as int)
	if cardsuit == CardSuit.JOKER:
		_cardbg.frame_coords.y = 0
	else:
		_cardbg.frame_coords.y = cardrank - 1

func set_starting_pos(pos:Vector2i) -> Card:
	_startingpos = pos
	return set_transition_pos(pos)

func set_data(cardrank:int, cardsuit:CardSuit) -> Card:
	rank = cardrank
	suit = cardsuit
	return self

func set_transition_pos(pos:Vector2i) -> Card:
	targetPosition = pos
	return self

func draw(tile:Vector2i) -> void:
	set_transition_pos((tile * Vector2i(50, 70)) + Vector2i(25, 35))

func discard() -> void:
	pass

func _to_string() -> String:
	return "Card: %s %s" % [rank, suit]
