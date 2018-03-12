# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var velocity = Vector2(0,0)
var smoothness = 0.5
var speed = 200
var ptr_game = null

func _ready():
	set_fixed_process(true)

func set_game_ptr(ptr):
	 ptr_game = ptr
	
func _fixed_process(delta):
	var direction = Vector2(0,0)
	var _pos = int(get_pos().x)
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("joy_left"):
		if _pos > 12: direction.x = -1
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("joy_right"):
		if _pos < Globals.get("CONFIG/WIDTH")-12: direction.x = 1

	velocity.x = lerp(velocity.x, speed * direction.x, smoothness)
	move(velocity * delta)
	
func hit():
	ptr_game.shorten_player_body()

func set_bonus(type):
	ptr_game.bonus_increment()
	ptr_game.extend_player_body()