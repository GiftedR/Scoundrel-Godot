extends Gameroot
class_name StandardGame

var deck:Array[Card]
var discard:Array[Card]
var room:Array[Card]
var deckstartingpos:Vector2i = Vector2i(0, -360)

var run_concurrent_count:int = 0

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

func _enter_tree() -> void:
	super._enter_tree()

func _ready() -> void:
	$cvl_Game_UI/ctr2_Game_UI/btn2_Run.pressed.connect(run_room)
	$cvl_Game_UI/ctr2_Game_UI/ctr2_Run.visible = false
	_refresh_board()
	# print(deck)
	new_room()

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

func new_room(didrun:bool = false) -> void:
	if !didrun:
		remainingDraws -= 4
		roomNumber += 1
	
	room.append(deck.pop_front().draw(Vector2i(-1, -1)))
	room.append(deck.pop_front().draw(Vector2i(0, -1)))
	room.append(deck.pop_front().draw(Vector2i(-1, 0)))
	room.append(deck.pop_front().draw(Vector2i(0, 0)))
	# deck[1].draw(Vector2i(-1, -1))
	# deck[1].draw(Vector2i(0, -1))
	# deck[2].draw(Vector2i(-1, 0))
	# deck[3].draw(Vector2i(0, 0))

func run_room() -> void:
	if run_concurrent_count == 1:
		$cvl_Game_UI/ctr2_Game_UI/ctr2_Run.visible = true
		await get_tree().create_timer(1).timeout
		$cvl_Game_UI/ctr2_Game_UI/ctr2_Run.visible = false
		return
	deck.append(room.pop_front().return_card(deckstartingpos))
	deck.append(room.pop_front().return_card(deckstartingpos))
	deck.append(room.pop_front().return_card(deckstartingpos))
	deck.append(room.pop_front().return_card(deckstartingpos))
	run_concurrent_count = 1
	new_room(true)

func refill_room() -> void:
	run_concurrent_count = 0
