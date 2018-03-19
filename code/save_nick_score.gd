
func _ready():
	self.grab_focus()


func save_and_go():
	var nick = get_text()
	if nick == '': nick = 'ANONYMOUS'
	save_score(nick, Globals.get("GAME/LAST_SCORE"))
	get_tree().change_scene("res://scenes/scoreboard.tscn")

func _on_nick_input_event( ev ):
	if Input.is_joy_button_pressed(0, JOY_XBOX_A) or Input.is_key_pressed(KEY_RETURN):
		save_and_go()

func save_score(nick, score):
	var file = File.new()
	file.open(Globals.get("CONFIG/SCORES_FILE"), File.READ_WRITE)
	var data = file.get_var()
	data.append([nick, score])
	file.seek(0)
	file.store_var(data)
	file.close()