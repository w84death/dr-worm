# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var menu_selected = 0
const MENU_START = 0
const MENU_HISCORE = 1
const MENU_EXIT = 2

func _ready():
	self.grab_focus()

func _on_menu_input_event( ev ):
	if Input.is_key_pressed(KEY_ESCAPE): exit()
	if Input.is_joy_button_pressed(0, JOY_XBOX_A) or Input.is_key_pressed(KEY_RETURN):
		if self.menu_selected == MENU_START: start_game()
		if self.menu_selected == MENU_HISCORE: show_hiscore()
		if self.menu_selected == MENU_EXIT: exit()

func _on_menu_button_selected( button_idx ):
	self.menu_selected = button_idx

func show_hiscore():
	pass

func start_game():
	get_tree().change_scene("res://scenes/game.tscn")

func exit():
	get_tree().quit()

