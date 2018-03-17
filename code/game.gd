# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

onready var scenes = {
	player = preload("res://scenes/worm.tscn"),
	player_body = preload("res://scenes/worm_body.tscn"),
	enemy = preload("res://scenes/bug.tscn"),
	obstacle = preload("res://scenes/rock.tscn"),
	bonus = preload("res://scenes/bonuses.tscn"),
	dopamine = preload("res://scenes/dopamine.tscn"),
	grassland = preload("res://scenes/grassland.tscn"),
	waterland = preload("res://scenes/waterland.tscn")}

onready var ptr = {
	timer_enemy = get_node("timer_enemy"),
	timer_bonus = get_node("timer_bonus"),
	timer_deadline = get_node("timer_deadline"),
	background = get_node("background"),
	terrain = get_node("terrain"),
	player = null, 
	player_last_body = null,
	side_panel = get_node("side_panel"),
	timer_panel = get_node("timer_panel"),
	timer_dopamine = get_node("timer_dopamine"),
	pills_box = get_node("side_panel/bonus/pills_box")}

var score = 0
var length = 0
var time_left = 0
var difficulty_time = 0
var protection = true
var score_bonus = 1
var dopamine_spawning = false

func _ready():
	init_game()

func return_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")

func init_game():
	set_map_type(Globals.get("GAME/MAP_TYPE"))
	set_difficulty(Globals.get("GAME/DIFFICULTY"))
	spawn_player(40, Globals.get("CONFIG/HEIGHT") - 32)
	ptr.timer_enemy.start()
	ptr.timer_bonus.start()
	ptr.timer_deadline.start()
	ptr.timer_dopamine.set_wait_time(Globals.get("GAME/DOPAMINE_TIME_SEC"))
	reset_time_left()
	for p in range(Globals.get("GAME/PLAYER_HP_ON_START")): extend_player_body()

func spawn_wave():
	var masks = [
		001,002,004,008,016,
		239,231,199,195,194,
		066,090,126,204,051,
		032,064,128,000,255]
	var bit_mask = masks[randi()%20]
	for x in range(0, 8):
		var bit = int(pow(2,x))
		if bit_mask & bit == bit: 
			if dopamine_spawning:
				spawn_dopamine(x*16)
			else:
				spawn_enemy(x*16)
	
func set_map_type(type):
	var new_terrain 
	if type == 0: new_terrain = scenes.grassland.instance()
	if type == 1: new_terrain = scenes.waterland.instance()
	ptr.background.add_child(new_terrain)

func set_difficulty(diff):
	if diff == 0: 
		difficulty_time = Globals.get("GAME/DIFF_EASY_TIME_SEC")
		score_bonus = Globals.get("GAME/DIFF_EASY_SCORE_BONUS")
	if diff == 1: 
		difficulty_time = Globals.get("GAME/DIFF_HARD_TIME_SEC")
		score_bonus = Globals.get("GAME/DIFF_HARD_SCORE_BONUS")

func spawn_player(x, y):
	var new_player = scenes.player.instance()
	new_player.set_position(Vector2(x, y))
	new_player.set_game_ptr(self)
	ptr.terrain.add_child(new_player)
	ptr.player = new_player
	ptr.player_last_body = new_player
	
func extend_player_body():
	length += 1
	var new_body = scenes.player_body.instance()
	new_body.set_pos(ptr.player_last_body.get_pos() + Vector2(0, 6))
	new_body.set_joint(ptr.player_last_body)
	ptr.terrain.add_child(new_body)
	ptr.player_last_body = new_body
	ptr.side_panel.get_node("size/size").set_text(str(length))

func shorten_player_body():
	length -= 1
	var recycle = ptr.player_last_body
	ptr.player_last_body = ptr.player_last_body.get_parent()
	recycle.hide()
	recycle.queue_free()
	ptr.side_panel.get_node("size/size").set_text(str(length))
	if length < 0: game_over()
	
func spawn_enemy(new_x):
	new_x += Globals.get("CONFIG/LEFT_MARGIN")
	var new_enemy = scenes.enemy.instance()
	new_enemy.set_pos(Vector2(new_x, -16))
	new_enemy.set_game_ptr(self)
	ptr.terrain.add_child(new_enemy)
	
func spawn_bonus(new_x):
	new_x += Globals.get("CONFIG/LEFT_MARGIN")
	var new_bonus = scenes.bonus.instance()
	new_bonus.set_pos(Vector2(new_x, -64))
	new_bonus.set_game_ptr(self)
	ptr.terrain.add_child(new_bonus)
	
func spawn_dopamine(new_x):
	new_x += Globals.get("CONFIG/LEFT_MARGIN")
	var new_dopamine = scenes.dopamine.instance()
	new_dopamine.set_pos(Vector2(new_x, -16))
	new_dopamine.set_game_ptr(self)
	ptr.terrain.add_child(new_dopamine)
	
func game_over():
	get_tree().change_scene("res://scenes/game_over.tscn")

func bonus_increment(id):
	score += score_bonus
	Globals.set("GAME/LAST_SCORE", score)
	ptr.side_panel.get_node("score/score").set_text(str(score))
	ptr.pills_box.add_pill(id)
	if ptr.pills_box.is_perfect(): start_dopamine_bonus()
	
func bonus_update(no):
	if no == 0: ptr.pills_box.reset_box()

func timer_update():
	ptr.timer_panel.get_node("time_left").set_text('0:0' + str(time_left))
	if time_left == 0:ptr.timer_panel.get_node("anim").play("flash")
	
func remove_me(trash):
	ptr.terrain.remove_child(trash)

func _on_timer_timeout():
	spawn_wave()

func _on_timer_bonus_timeout():
	var bonus_x = int(randi()%8)
	spawn_bonus(bonus_x*16)


func _on_timer_deadline_timeout():
	time_left -= 1
	if time_left < 0:
		reset_time_left()
		ptr.player.flash()
		shorten_player_body()
		Input.stop_joy_vibration(0)
		Input.start_joy_vibration(0, 0.5, 0.8, 0.5)
	timer_update()
	
func reset_time_left():
	time_left = difficulty_time
	timer_update()
	
func change_terrain(id):
	ptr.background.get_node("terrain").set_ground(id)

func start_dopamine_bonus():
	dopamine_spawning = true
	ptr.pills_box.get_node("perfect").play("perfect")
	ptr.timer_dopamine.start()
	
func _on_timer_dopamine_timeout():
	dopamine_spawning = false
