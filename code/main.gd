extends Control

func _ready():
	Globals.set("CONFIG/WIDTH", 200)
	Globals.set("CONFIG/HEIGHT", 150)
	Globals.set("CONFIG/HALF_WIDTH", 100)
	Globals.set("CONFIG/VERSION", "0.3")
	get_tree().change_scene("res://scenes/menu.tscn")
	Globals.set("GAME/MAP_TYPE", 0)