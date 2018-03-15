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
	grassland = preload("res://scenes/grassland.tscn"),
	waterland = preload("res://scenes/waterland.tscn")}

onready var ptr = {
	timer_enemy = get_node("timer_enemy"),
	timer_bonus = get_node("timer_bonus"),
	background = get_node("background"),
	terrain = get_node("terrain"),
	player = null, 
	player_last_body = null,
	gui_game_over = get_node("GUI/game_over"),
	side_panel = get_node("side_panel"),
	bonus_panel = get_node("bonus_panel"),
	timer_panel = get_node("timer_panel")}

var score = 0
var length = 0
var time_left = 6

func _ready():
	init_game()

func return_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")

func init_game():
	set_map_type(Globals.get("GAME/MAP_TYPE"))
	spawn_player(40, Globals.get("CONFIG/HEIGHT") - 32)
	ptr.timer_enemy.start()
	ptr.timer_bonus.start()
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
			spawn_enemy((x*16))

func set_map_type(type):
	var new_terrain 
	if type == 0: new_terrain = scenes.grassland.instance()
	if type == 1: new_terrain = scenes.waterland.instance()
	ptr.background.add_child(new_terrain)

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
	ptr.side_panel.get_node("list/size/size").set_text(str(length))

func shorten_player_body():
	length -= 1
	var recycle = ptr.player_last_body
	ptr.player_last_body = ptr.player_last_body.get_parent()
	recycle.hide()
	recycle.queue_free()
	ptr.side_panel.get_node("list/size/size").set_text(str(length))
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
	
func game_over():
	ptr.timer_enemy.stop()
	ptr.timer_bonus.stop()
	ptr.gui_game_over.get_node("score/score").set_text(str(score))
	ptr.terrain.hide()
	ptr.side_panel.hide()
	ptr.bonus_panel.hide()
	ptr.timer_panel.hide()
	ptr.gui_game_over.show()
	ptr.gui_game_over.get_node("panel/menu").grab_focus()

func bonus_increment():
	score += 1
	ptr.side_panel.get_node("list/pills/pills").set_text(str(score))
	
func bonus_update():
	ptr.bonus_panel.get_node("bonus").set_text(str(ptr.player.bonus) + '/' + str(Globals.get("GAME/BONUS_TO_HEALTH")))

func timer_update():
	ptr.timer_panel.get_node("time_left").set_text('0:0' + str(time_left))
	
func remove_me(trash):
	ptr.terrain.remove_child(trash)

func _on_timer_timeout():
	spawn_wave()

func _on_timer_bonus_timeout():
	spawn_bonus(int(randi()%8)*16)

func _on_timer_deadline_timeout():
	time_left -= 1
	if time_left < 0:
		reset_time_left()
		shorten_player_body()
		Input.stop_joy_vibration(0)
		Input.start_joy_vibration(0, 0.5, 0.8, 0.5)
	timer_update()
	
func reset_time_left():
	time_left = Globals.get("GAME/DEADLINE_TIME_SEC")
	timer_update()