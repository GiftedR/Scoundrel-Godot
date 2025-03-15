extends Card
class_name DiamondsCard

static func create(startingposition:Vector2i = Vector2i.ZERO) -> Card:
	return load("res://Pieces/Cards/p_Diamonds.tscn").instantiate().set_starting_pos(startingposition)

func set_data(cardrank:int, _cardsuit:CardSuit = CardSuit.DIAMONDS) -> Card:
	return super.set_data(cardrank, CardSuit.DIAMONDS)
