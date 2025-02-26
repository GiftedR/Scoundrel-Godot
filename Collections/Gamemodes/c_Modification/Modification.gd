extends Gameroot
class_name ModificationGame

func _enter_tree() -> void:
	print_rich("[color=yellow]Modification Gamemode currently not implimented [/color]");
	get_tree().change_scene_to_packed(load("res://Collections/c_GameRoot.tscn"))
