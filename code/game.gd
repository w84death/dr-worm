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
	background = get_node("background"),
	terrain = get_node("terrain"),
	player = null, 
	player_last_body = null,
	gui_game_over = get_node("GUI/game_over")}

var score = 0
var active_bonus = 0
var length = 0

const BONUS_NONE = 0
const BONUS_SPEED = 1
const BONUS_ENLARGE = 2
const BONUS_BULLET_TIME = 3

func _ready():
	init_game()

func return_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")

func init_game():
	set_map_type(Globals.get("GAME/MAP_TYPE"))
	spawn_player(Globals.get("CONFIG/HALF_WIDTH"), Globals.get("CONFIG/HEIGHT") - 48)
	extend_player_body()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_bonus()
	spawn_bonus()
	spawn_bonus()

func set_map_type(type):
	var new_terrain 
	if type == 0: new_terrain = scenes.grassland.instance()
	if type == 1: new_terrain = scenes.waterland.instance()
	ptr.background.add_child(new_terrain)

func spawn_player(x, y):
	var new_player = scenes.player.instance()
	new_player.set_pos(Vector2(x, y))
	new_player.set_game_ptr(self)
	ptr.terrain.add_child(new_player)
	ptr.player = new_player
	ptr.player_last_body = new_player
	
func extend_player_body():
	length += 1
	var new_body = scenes.player_body.instance()
	new_body.set_pos(ptr.player_last_body.get_pos() + Vector2(0, 6))
	new_body.set_joint(ptr.player_last_body)
	new_body.decrese_speed(length*10)
	ptr.terrain.add_child(new_body)
	ptr.player_last_body = new_body

func shorten_player_body():
	length -= 1
	var recycle = ptr.player_last_body
	ptr.player_last_body = ptr.player_last_body.get_parent()
	recycle.hide()
	recycle.queue_free()
	if length < 0: game_over()
	
func spawn_enemy():
	var new_enemy = scenes.enemy.instance()
	new_enemy.set_pos(Vector2(32 + randi()%(Globals.get("CONFIG/WIDTH")-16), -16 - randi()%128))
	new_enemy.set_game_ptr(self)
	ptr.terrain.add_child(new_enemy)
	
func spawn_bonus():
	var new_bonus = scenes.bonus.instance()
	new_bonus.set_pos(Vector2(32 + randi()%(Globals.get("CONFIG/WIDTH")-16), -16 - randi()%128))
	new_bonus.set_game_ptr(self)
	ptr.terrain.add_child(new_bonus)
	
func game_over():
	ptr.terrain.hide()
	ptr.terrain.queue_free()
	ptr.gui_game_over.show()
	ptr.gui_game_over.get_node("panel/menu").grab_focus()