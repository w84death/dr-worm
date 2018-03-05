# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

export var speed = 96
var velocity = Vector2(0, speed)
var ptr_game = null

const CONFIG = {
	WIDTH = 200,
	HEIGHT = 150,
	CENTER_W = 100,
	VERSION = '0.3'}
	
func _ready():
	set_fixed_process(true)

func set_game_ptr(ptr):
	 ptr_game = ptr
	
func _fixed_process(delta):
	move(velocity * delta)
	# DEMO
	if get_pos().y > 150: set_pos(Vector2(32 + randi()%(CONFIG.WIDTH-16), -8 - randi()%32))

	if is_colliding():
		get_collider().hit()
		ptr_game.spawn_enemy()
		hide()
		queue_free()