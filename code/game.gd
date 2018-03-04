# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

onready var scenes = {
	player = preload("res://scenes/worm.tscn"),
	player_body = preload("res://scenes/worm_body.tscn"),
	enemy = preload("res://scenes/bug.tscn"),
	obstacle = preload("res://scenes/rock.tscn"),
	bonus = preload("res://scenes/bonuses.tscn")}

onready var ptr = {
	background = get_node("background"),
	terrain = get_node("terrain"),
	player = null, 
	player_last_body = null}

var score = 0
var active_bonus = 0
var length = 0

const BONUS_NONE = 0
const BONUS_SPEED = 1
const BONUS_ENLARGE = 2
const BONUS_BULLET_TIME = 3
const CONFIG = {
	WIDTH = 200,
	HEIGHT = 150,
	CENTER_W = 100,
	VERSION = '0.3'}

func _ready():
	init_game()

func return_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")

func init_game():
	spawn_player(CONFIG.CENTER_W, CONFIG.HEIGHT - 48)
	extend_player_body()
	extend_player_body()
	extend_player_body()
	extend_player_body()
	extend_player_body()
	extend_player_body()
	extend_player_body()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()

func spawn_player(x, y):
	var new_player = scenes.player.instance()
	new_player.set_pos(Vector2(x, y))
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
	
func spawn_enemy():
	var new_enemy = scenes.enemy.instance()
	new_enemy.set_pos(Vector2(32 + randi()%(CONFIG.WIDTH-16), -16 - randi()%32))
	ptr.terrain.add_child(new_enemy)