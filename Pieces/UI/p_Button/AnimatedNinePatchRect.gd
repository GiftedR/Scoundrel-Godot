@tool
extends NinePatchRect
class_name AnimatedNinePatchRect

@export_group("Animation")
@export var sprite_frames:SpriteFrames
@export var animation = 0 ## Animation is in an int form as there is currently no way to populate an enum based on the spriteframe
@export var frame:int = 0:
	set(value):
		_animationFrame = value
		texture = sprite_frames.get_frame_texture(_animationName, _animationFrame)
	get:
		return _animationFrame
@export var speed_scale:float = 1.0

var _animationName:String :
	get:
		return Array(sprite_frames.get_animation_names())[animation]

var _animationFrame:int
