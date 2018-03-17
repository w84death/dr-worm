extends Control

onready var ptr_ground = get_node("ground")

var TEXTURES = [
	load("res://assets/terrain0.png"),
	load("res://assets/terrain1.png"),
	load("res://assets/terrain2.png"),
	load("res://assets/terrain3.png")]
	
func _ready():
	set_ground(int(randi()%4))

func set_ground(id=3):
	ptr_ground.set_texture(TEXTURES[id])