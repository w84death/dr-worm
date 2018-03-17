# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var menu_selected = 0
const MENU_EASY = 0
const MENU_HARD = 1
const MENU_BACK = 2

func _ready():
	self.grab_focus()
	Globals.set("GAME/MAP_TYPE", menu_selected)
	Globals.set("GAME/DIFFICULTY", menu_selected)
	
func _on_menu_input_event( ev ):
	if Input.is_key_pressed(KEY_ESCAPE): go_back()
	if Input.is_joy_button_pressed(0, JOY_XBOX_A) or Input.is_key_pressed(KEY_RETURN):
		if self.menu_selected == MENU_EASY: start_game()
		if self.menu_selected == MENU_HARD: start_game()
		if self.menu_selected == MENU_BACK: go_back()

func _on_menu_button_selected( button_idx ):
	self.menu_selected = button_idx
	get_node("menu_sound").play()
	if button_idx < 2:
		Globals.set("GAME/DIFFICULTY", button_idx)

func show_hiscore():
	pass

func start_game():
	get_tree().change_scene("res://scenes/game.tscn")

func go_back():
	get_tree().change_scene("res://scenes/menu.tscn")