# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var velocity = Vector2(0,0)
var ptr_game = null
onready var ptr_anim = get_node("anim") 
var target = Vector2(0,0)
var bonus = 0

func _ready():
	set_fixed_process(true)

func set_position(pos):
	set_pos(pos)
	target = pos
	
func set_game_ptr(ptr):
	 ptr_game = ptr
	
func _fixed_process(delta):
	var direction = Vector2(0,0)
	var _pos = int(get_pos().x)
	var _target = int(target.x)
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("joy_left"):
		if abs(_target - _pos) < 8 and _pos > 16:
			target.x -= 16
			target.x = int(target.x/8)*8
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("joy_right"):
		if abs(_target - _pos) < 8 and _pos < Globals.get("CONFIG/WIDTH")-16: 
			target.x += 16
			target.x = int(target.x/8)*8

	if _target < _pos: direction.x = -4
	if _target > _pos: direction.x = 4
	
	set_pos(get_pos() + direction)
	
func hit():
	ptr_game.play_sfx("hit")
	flash()
	ptr_game.shorten_player_body()
	bonus = 0
	ptr_game.bonus_update(bonus)
	Input.stop_joy_vibration(0)
	Input.start_joy_vibration(0, 0.5, 0.8, 0.5)

func set_bonus(type):
	ptr_game.play_sfx("pill")
	ptr_game.reset_time_left()
	ptr_game.bonus_increment(type)
	ptr_game.change_terrain(type)
	bonus += 1
	Input.start_joy_vibration(0, 0.0, 0.2, 0.2)
	if bonus >= Globals.get("GAME/BONUS_TO_HEALTH"):
		ptr_game.extend_player_body()
		Input.start_joy_vibration(0, 0.0, 0.5, 0.5)
		bonus = 0
	ptr_game.bonus_update(bonus)
	
func set_dopamine():
	ptr_game.score_increment(1)
	ptr_game.play_sfx("dopamine")
	
func flash():
	ptr_anim.play("flash")
	
func push_form_safe_zone():
	ptr_game.play_sfx("hit")
	var _pos = int(get_pos().x)
	if _pos < Globals.get("CONFIG/HALF_WIDTH"):
		target.x += 32
	else:
		target.x -= 32
	target.x = int(target.x/8)*8