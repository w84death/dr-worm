# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

onready var scenes = {
	player = preload("res://scenes/worm.tscn"),
	enemy = preload("res://scenes/bug.tscn"),
	obstacle = preload("res://scenes/rock.tscn"),
	bonus = preload("res://scenes/bonuses.tscn")}

onready var ptr = {
	background = get_node("background"),
	terrain = get_node("terrain")}

var score = 0
var active_bonus = 0
const BONUS_NONE = 0
const BONUS_SPEED = 1
const BONUS_ENLARGE = 2
const BONUS_BULLET_TIME = 3
const CONFIG = {
	WIDTH = 200,
	HEIGHT = 150,
	CENTER_W = 100,
	VERSION = '0.2'}

func _ready():
	init_game()

func _on_game_input_event( ev ):
	if Input.is_joy_button_pressed(0, JOY_XBOX_B) or Input.is_key_pressed(KEY_ESCAPE): return_to_menu()

func return_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")

func init_game():
	spawn_player(CONFIG.CENTER_W, CONFIG.HEIGHT - 32)

func spawn_player(x, y):
	var new_player = scenes.player.instance()
	new_player.set_pos(Vector2(x, y))
	ptr.terrain.add_child(new_player)
