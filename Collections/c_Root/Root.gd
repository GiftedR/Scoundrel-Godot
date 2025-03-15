extends Node
class_name Root

static var Instance:Root

@export_file("*.tscn") var GameToLoad:String = "res://Collections/c_GameRoot.tscn"

var _loadedGame:Gameroot

func _init() -> void:
	Instance = self

func _enter_tree() -> void:
	load_game(GameToLoad)

func load_game(path:String) -> void:
	if _loadedGame != null:
		_loadedGame.queue_free()
		_loadedGame = null
	add_child(MainCamera.Create())
	var game:Gameroot = load(path).instantiate()
	_loadedGame = game
	add_child.call_deferred(game)
	game.name = "Main Game"

func setFullScreen() -> void:
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		_: # DisplayServer.WINDOW_MODE_WINDOWED | [Any Undefined]
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"):
		setFullScreen()
	if Input.is_action_just_pressed("dev_1"):
		OilBoard.random_oil_transition()
	if Input.is_action_just_pressed("dev_2"):
		OilBoard.random_solid_transition()
