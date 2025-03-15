extends Gameroot
class_name DeckShowcase

var deck:Array[Card]

var heartCards:int = 13 # 9
var diamondsCards:int = 13 # 9
var clubsCards:int = 13 # 13
var spadesCards:int = 13 # 13

func _init() -> void:
	super()
	_reset_deck()

func _enter_tree() -> void:
	super._enter_tree()

func _ready() -> void:
	print(deck)
	_refresh_board()

func _refresh_board() -> void:
	if board != null && board.get_child_count() > 0:
		_clear_board()
	for c:Card in deck:
		board.add_child(c)

func _reset_deck() -> void:
	deck = []
	
	for rank:int in heartCards:
		@warning_ignore("narrowing_conversion")
		deck.append(Card.create(Vector2i((rank * 50) - (heartCards * 50 / 2), -140)).set_data(rank + 1, Card.CardSuit.HEARTS))
	for rank:int in diamondsCards:
		@warning_ignore("narrowing_conversion")
		deck.append(Card.create(Vector2i((rank * 50) - (diamondsCards * 50 / 2), -45)).set_data(rank + 1, Card.CardSuit.DIAMONDS))
	for rank:int in clubsCards:
		@warning_ignore("narrowing_conversion")
		deck.append(Card.create(Vector2i((rank * 50) - (clubsCards * 50 / 2), 45)).set_data(rank + 1, Card.CardSuit.CLUBS))
	for rank:int in spadesCards:
		@warning_ignore("narrowing_conversion")
		deck.append(Card.create(Vector2i((rank * 50) - (clubsCards * 50 / 2), 140)).set_data(rank + 1, Card.CardSuit.SPADES))
