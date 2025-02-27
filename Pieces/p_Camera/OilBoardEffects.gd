extends ColorRect
class_name OilBoard

static var Instance:OilBoard

var _currentColors:Array[Color] = [Color("0000ff"),Color("ff0000"),Color("ffffff")]
var _targetColors:Array[Color] = []
var _trans:bool = false

const _colors:Array[Color] = [
	Color("ff0000"),
	Color("0fF000"),
	Color("00ff00"),
	Color("000ff0"),
	Color("0000ff"),
	Color("f0000f"),
	Color("fff000"),
	Color("0fff00"),
	Color("00fff0"),
	Color("000fff"),
	Color("f000ff"),
	Color("ff000f"),
	Color("ffff00"),
	Color("0ffff0"),
	Color("00ffff"),
	Color("f00fff"),
	Color("ff00ff"),
	Color("fff00f"),
	Color("ffff00"),
	Color("fffff0"),
	Color("0fffff"),
	Color("f0ffff"),
	Color("ff0fff"),
	Color("fff0ff"),
	Color("ffff0f"),
	Color("ffffff"),
	Color("000000")
	]

func _init() -> void:
	Instance = self
	_targetColors = _currentColors

func _physics_process(delta: float) -> void:
	_trans = false
	
	if _currentColors[0] != _targetColors[0]:
		_currentColors[0] = _currentColors[0].lerp(_targetColors[0], delta)
		_trans = true
	
	if _currentColors[1] != _targetColors[1]:
		_currentColors[1] = _currentColors[1].lerp(_targetColors[1], delta)
		_trans = true
	
	if _currentColors[2] != _targetColors[2]:
		_currentColors[2] = _currentColors[2].lerp(_targetColors[2], delta)
		_trans = true
	
	if _trans:
		set_oil_color(_currentColors[0],_currentColors[1],_currentColors[2])

func transition_oil_color(dark_color:Color = _currentColors[0], 
		mid_color:Color = _currentColors[1], 
		light_color:Color = _currentColors[2]) -> void:
	
	_targetColors = [dark_color, mid_color, light_color]

func set_oil_color(dark_color:Color = _currentColors[0], 
		mid_color:Color = _currentColors[1], 
		light_color:Color = _currentColors[2]) -> void:
	
	var gradienttexture:GradientTexture1D = material.get("shader_parameter/oil_tint_gradient")
	var gradient:Gradient = gradienttexture.get_gradient()
	
	gradient.set_color(0, dark_color)
	gradient.set_color(1, mid_color)
	gradient.set_color(2, light_color)
	
	gradienttexture.set_gradient(gradient)
	material.set("shader_parameter/oil_tint_gradient", gradienttexture)

static func static_oil_color(dark_color:Color, mid_color:Color, light_color:Color) -> void:
	Instance.set_oil_color(dark_color, mid_color, light_color)

static func set_oil_transition(dark_color:Color, mid_color:Color, light_color:Color) -> void:
	Instance.transition_oil_color(dark_color, mid_color, light_color)

static func set_solid_color(color:Color) -> void:
	static_oil_color(color,color,Color.WHITE)

static func set_solid_transition(color:Color) -> void:
	set_oil_transition(color, color, Color.WHITE)

static func random_oil_transition() -> void:
	set_oil_transition(_colors.pick_random(), _colors.pick_random(), _colors.pick_random())

static func random_solid_transition() -> void:
	set_solid_transition(_colors.pick_random())
