
func _ready():
	self.grab_focus()

func _on_menu_input_event( ev ):
	if Input.is_joy_button_pressed(0, JOY_XBOX_A) or Input.is_key_pressed(KEY_RETURN):
		get_tree().change_scene("res://scenes/menu.tscn")