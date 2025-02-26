extends Area2D
class_name Card

static func create() -> Card:
	return load("res://Pieces/p_Card.tscn").instantiate()
