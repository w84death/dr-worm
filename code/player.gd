# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var velocity = Vector2(0,0)
var smoothness = 0.5
var speed = 200

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var direction = Vector2(0,0)
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("joy_left"):
		if get_pos().x > 4: direction.x = -1
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("joy_right"):
		if get_pos().x < 196: direction.x = 1
	
	velocity.x = lerp(velocity.x, speed * direction.x, smoothness)
	move(velocity * delta)
	
	if is_colliding():
		print('colliding')