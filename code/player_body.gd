# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var ptr_parent = null
var velocity = Vector2(0,0)
var smoothness = 0.5
var speed = 200

func _ready():
	set_fixed_process(true)

func set_joint(ptr_body):
	ptr_parent = ptr_body

func decrese_speed(decrese):
	speed -= decrese
	
func _fixed_process(delta):
	var direction = Vector2(0,0)
	if ptr_parent:
		var diff = int(ptr_parent.get_pos().x - get_pos().x)
		if diff < -2: direction.x = -1
		if diff > 2: direction.x = 1
	
	velocity.x = lerp(velocity.x, speed * direction.x, smoothness)
	
	move(velocity * delta)
	
	if get_pos().x < 4: set_pos(Vector2(196, get_pos().y))
	if get_pos().x >196: set_pos(Vector2(4, get_pos().y))

