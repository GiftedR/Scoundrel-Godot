extends Gameroot
class_name StandardGame

var deck:Array[Card]
var deckstartingpos:Vector2i = Vector2i(0, -360)

var heartCards:int = 9 # 9
var diamondsCards:int = 9 # 9
var clubsCards:int = 13 # 13
var spadesCards:int = 13 # 13

func _init() -> void:
	super()
	_reset_deck()
	deckSize = 44
	remainingDraws = 44
	for i:int in 7:
		deck.shuffle()
	new_room()

func _enter_tree() -> void:
	super._enter_tree()

func _ready() -> void:
	_refresh_board()
	print(deck)

func _refresh_board() -> void:
	if board != null && board.get_child_count() > 0:
		_clear_board()
	for c:Card in deck:
		board.add_child(c)

func _reset_deck() -> void:
	deck = []
	
	for rank:int in heartCards:
		deck.append(HeartsCard.create(Vector2i(deckstartingpos)).set_data(rank + 2, (0 as Card.CardSuit)))
	for rank:int in diamondsCards:
		deck.append(DiamondsCard.create(Vector2i(deckstartingpos)).set_data(rank + 2, (0 as Card.CardSuit)))
	for rank:int in clubsCards:
		deck.append(ClubsCard.create(Vector2i(deckstartingpos)).set_data(rank + 1, (0 as Card.CardSuit)))
	for rank:int in spadesCards:
		deck.append(SpadesCard.create(Vector2i(deckstartingpos)).set_data(rank + 1, (0 as Card.CardSuit)))

func new_room() -> void:
	remainingDraws -= 4
	roomNumber += 1
	
	deck[0].draw(Vector2i(-1, -1))
	deck[1].draw(Vector2i(0, -1))
	deck[2].draw(Vector2i(-1, 0))
	deck[3].draw(Vector2i(0, 0))
