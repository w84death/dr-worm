# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var ptr_parent = null
var target = Vector2(0,0)

func _ready():
	set_fixed_process(true)

func set_joint(ptr_body):
	ptr_parent = ptr_body
	
func _fixed_process(delta):
	var direction = Vector2(0,0)
	var _pos = int(get_pos().x)
	var _parent = int(ptr_parent.get_pos().x)
	var _target = int(target.x)
	
	if ptr_parent:
		if abs(_pos - _parent) > 12:
			target.x = _parent
			target.x = int(target.x/8)*8
	
	
	if _target < _pos: direction.x = -4
	if _target > _pos: direction.x = 4

	set_pos(get_pos() + direction)

func get_parent():
	return ptr_parent