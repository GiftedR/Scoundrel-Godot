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

static var hoveredCard:Card

const cardSize:Vector2i = Vector2i(50, 70)
var card_action:Callable = func() -> void: queue_free()
var is_drawn:bool = false
var draw_id:int = -1

@export_range(1, 13) var rank:int = 1
@export var suit:CardSuit = CardSuit.HEARTS
@export var targetPosition:Vector2 = Vector2.ZERO

@onready var _outline: AnimatedSprite2D = $asp2_Card_Outline
@onready var _cardbg:Sprite2D = $spe2_Card_Body
@onready var _tooltip:PanelContainer = $plc2_Tooltip

var _startingpos:Vector2i = Vector2i.ZERO

func _enter_tree() -> void:
	mouse_entered.connect(_hover)
	
	mouse_exited.connect(_unhover)
	
	position = _startingpos

func _ready() -> void:
	_outline.visible = false
	_tooltip.visible = false
	
	input_event.connect(func(_vp:Node, event:InputEvent, _shpidx:int) -> void:
		if event is InputEventMouseMotion:
			_hover()
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT && event.pressed == false:
				card_action.call()
	)

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

func set_transition_pos(pos:Vector2i, is_tile_pos:bool = false) -> Card:
	var newpos:Vector2i = pos if !is_tile_pos else ((pos * cardSize) + cardSize / 2)
	targetPosition = newpos
	return self

func draw(tile:Vector2i) -> Card:
	set_transition_pos((tile * cardSize) + cardSize / 2)
	is_drawn = true
	return self

func return_card(startingposition:Vector2i) -> Card:
	draw(startingposition)
	is_drawn = false
	return self

func discard() -> void:
	pass

func _to_string() -> String:
	return "Card: %s of %s" % [rank, suit_name(suit)]

static func suit_name(cardsuit:int) -> String:
	match (cardsuit):
		0:
			return "Hearts"
		1:
			return "Diamonds"
		2:
			return "Clubs"
		3:
			return "Spades"
		4:
			return "Jokers"
		_:
			return "%s" % cardsuit

static func rank_name(cardrank:int) -> String:
	match (cardrank):
		1:
			return "Ace"
		11:
			return "Jack"
		12:
			return "Queen"
		13:
			return "King"
		_:
			return "%s" % cardrank

func _hover() -> void:
	if hoveredCard == null:
		_outline.visible = true
		_tooltip.visible = true
		hoveredCard = self

func _unhover() -> void:
	if hoveredCard != null:
		_outline.visible = false
		_tooltip.visible = false
		hoveredCard = null

func with_draw_id(id:int = -1) -> Card:
	draw_id = id
	return self