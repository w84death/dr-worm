# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

export var speed = 96
var velocity = Vector2(0, speed)
var ptr_game = null

func _ready():
	set_fixed_process(true)

func set_game_ptr(ptr):
	 ptr_game = ptr

	
func _fixed_process(delta):
	move(velocity * delta)

	if get_pos().y > Globals.get("CONFIG/HEIGHT") + 16:
		die()

	if is_colliding():
		remove_child(get_node("collision"))
		get_collider().push_form_safe_zone()

func die():
	ptr_game.remove_me(self)
	queue_free()
	
func hit():
	pass
	
func set_bonus(dumb):
	pass