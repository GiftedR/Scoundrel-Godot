extends Node
class_name Helpers

static var Instance:Helpers

func _init() -> void:
	Instance = self

static var _lastMessage:String = ""
static func distinct_print(message:Array) -> void:
	if str(message) != _lastMessage:
		print(message)
		_lastMessage = str(message)
