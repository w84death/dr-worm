# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var menu_selected = 0
const MENU_RESTART = 0
const MENU_BACK = 1

func _ready():
	self.grab_focus()

func _on_menu_input_event( ev ):
	if Input.is_key_pressed(KEY_ESCAPE): go_back()
	if Input.is_joy_button_pressed(0, JOY_XBOX_A) or Input.is_key_pressed(KEY_RETURN):
		if self.menu_selected == MENU_RESTART: choose_map()
		if self.menu_selected == MENU_BACK: go_back()

func _on_menu_button_selected( button_idx ):
	self.menu_selected = button_idx

func choose_map():
	get_tree().change_scene("res://scenes/choose_map.tscn")
	
func go_back():
	get_tree().change_scene("res://scenes/menu.tscn")