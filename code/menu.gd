extends VButtonArray

func _ready():
	self.grab_focus()

func _on_menu_button_selected( button_idx ):
	if button_idx == 2:
		get_tree().quit()
	if button_idx == 0:
		get_tree().change_scene("res://scenes/game.tscn")