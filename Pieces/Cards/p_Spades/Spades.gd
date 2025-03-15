extends Card
class_name SpadesCard

static func create(startingposition:Vector2i = Vector2i.ZERO) -> Card:
	return load("res://Pieces/Cards/p_Spades.tscn").instantiate().set_starting_pos(startingposition)

func set_data(cardrank:int, _cardsuit:CardSuit = CardSuit.SPADES) -> Card:
	return super.set_data(cardrank, CardSuit.SPADES)
