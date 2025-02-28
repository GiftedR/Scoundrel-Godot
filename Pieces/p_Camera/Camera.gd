extends Camera2D
class_name MainCamera

static var Instance:MainCamera

static func Create() -> MainCamera:
	return load("res://Pieces/p_Camera.tscn").instantiate()

static func Rebuild() -> void:
	if !Instance.is_inside_tree():
		return
	if Instance != null:
		Instance.queue_free()
		Instance = null
	
	Instance = Create()
	Gameroot.Instance.add_child(Instance)

func _init() -> void:
	Instance = self
