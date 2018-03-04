# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var velocity = Vector2(0,0)
var smoothness = 0.4
var speed = 100

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var direction = Vector2(0,0)

	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	
	velocity.x = lerp(velocity.x, speed * direction.x, smoothness)
	velocity.y = lerp(velocity.y, speed * direction.y, smoothness)

	move(velocity * delta)
