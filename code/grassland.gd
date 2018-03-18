# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

onready var ptr_ground = get_node("ground")
var text_bank = 0
var last_id = 0

var TEXTURES = [[
	load("res://assets/terrain0.png"),
	load("res://assets/terrain1.png"),
	load("res://assets/terrain2.png"),
	load("res://assets/terrain3.png")],
	[
	load("res://assets/terrain0_alt.png"),
	load("res://assets/terrain1_alt.png"),
	load("res://assets/terrain2_alt.png"),
	load("res://assets/terrain3_alt.png")]]
	
func _ready():
	set_ground(int(randi()%4))

func set_ground(id=3):
	if last_id == id:
		if text_bank == 1: text_bank = 0
		else: text_bank = 1
	else:
		text_bank = 0
	last_id = id
	ptr_ground.set_texture(TEXTURES[text_bank][id])