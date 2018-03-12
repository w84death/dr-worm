# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

export var speed = 96
export var bonus_type = 0
var velocity = Vector2(0, speed)
var ptr_game = null

onready var ptr_body = get_node("body")
	
func _ready():
	randomize()
	set_random_bonus()
	set_fixed_process(true)

func set_game_ptr(ptr):
	 ptr_game = ptr

func set_random_bonus():
	ptr_body.set_frame(int(randi()%6))
	
func _fixed_process(delta):
	move(velocity * delta)

	if get_pos().y > Globals.get("CONFIG/HEIGHT") + 16:
		die()

	if is_colliding():
		get_collider().set_bonus(bonus_type)
		die()

func die():
	ptr_game.remove_me(self)
	queue_free()