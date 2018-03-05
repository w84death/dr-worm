extends Control

func _ready():
	set_globals()
	go_to_menu()

func set_globals():
	Globals.set("CONFIG/WIDTH", 200)
	Globals.set("CONFIG/HEIGHT", 150)
	Globals.set("CONFIG/HALF_WIDTH", 100)
	Globals.set("GAME/VERSION", "ALPHA 4")
	Globals.set("GAME/MAP_TYPE", 0)

func go_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")