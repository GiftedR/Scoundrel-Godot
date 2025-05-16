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
	diamondsCards = 0
	clubsCards = 0
	spadesCards = 0
	_reset_deck()
	# deckSize = 44
	remainingDraws = 44
	for i:int in 7:
		deck.shuffle()

func _enter_tree() -> void:
	super._enter_tree()

func _ready() -> void:
	$cvl_Game_UI/ctr2_Game_UI/btn2_Run.pressed.connect(run_room)
	$cvl_Game_UI/ctr2_Game_UI/ctr2_Win/ccc2_Info/ctr2_Victory/btn2_New_Game.pressed.connect( func() -> void: win())
	$cvl_Game_UI/ctr2_Game_UI/ctr2_Win/ccc2_Info/ctr2_Victory/btn2_Quit.pressed.connect(get_tree().quit)
	$cvl_Game_UI/ctr2_Game_UI/ctr2_Run.visible = false
	$cvl_Game_UI/ctr2_Game_UI/ctr2_Win.visible = false
	_refresh_board()
	new_room()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	Helpers.distinct_print(deck)
	if room.size() < 2 && deck.size() > 0:
		refill_room()
		print("REFILL!")
	for i:int in room.size():
		if i < room.size() && room[i] == null:
			room.pop_at(i)
	if room.size() == 0 && deck.size() == 0:
		$cvl_Game_UI/ctr2_Game_UI/ctr2_Win.visible = true
		
		# win()

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
	room.append(deck.pop_front().draw(Vector2i(-1, -1)).with_draw_id(0))
	room.append(deck.pop_front().draw(Vector2i(0, -1)).with_draw_id(1))
	room.append(deck.pop_front().draw(Vector2i(-1, 0)).with_draw_id(2))
	room.append(deck.pop_front().draw(Vector2i(0, 0)).with_draw_id(3))
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
	new_room()

func refill_room() -> void:
	var sizecount:int = deck.size()

	run_concurrent_count = 0
	remainingDraws = deck.size()
	roomNumber += 1
	room[0].set_transition_pos(Vector2i(-1, -1), true).with_draw_id(0)
	print("SIZE -> ", deck.size())
	if sizecount >= 1:
		room.append(deck.pop_front().draw(Vector2i(0, -1)).with_draw_id(1))
	if sizecount >= 2:
		room.append(deck.pop_front().draw(Vector2i(-1, 0)).with_draw_id(2))
	if sizecount >= 3:
		room.append(deck.pop_front().draw(Vector2i(0, 0)).with_draw_id(3))
