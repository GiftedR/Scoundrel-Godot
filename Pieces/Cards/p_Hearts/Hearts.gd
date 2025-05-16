extends Card
class_name HeartsCard

func _init() -> void:
	card_action = func() -> void:
		Root.Instance._loadedGame.add_health(rank)
		queue_free()

static func create(startingposition:Vector2i = Vector2i.ZERO) -> Card:
	return load("res://Pieces/Cards/p_Hearts.tscn").instantiate().set_starting_pos(startingposition)

func set_data(cardrank:int, _cardsuit:CardSuit = CardSuit.HEARTS) -> Card:
	return super.set_data(cardrank, CardSuit.HEARTS)
