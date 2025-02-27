extends Node
class_name Root

static var Instance:Root

@export_dir var GameToLoad:String = "res://Collections/c_GameRoot.tscn"

var _loadedGame:Gameroot

func _init() -> void:
	Instance = self

func _enter_tree() -> void:
	load_game(GameToLoad)

func load_game(path:String) -> void:
	if _loadedGame != null:
		_loadedGame.queue_free()
		_loadedGame = null
	
	var game:Gameroot = load(path).instantiate()
	_loadedGame = game
	add_child.call_deferred(game)
	game.name = "Main Game"

func setFullScreen() -> void:
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"):
		setFullScreen()
