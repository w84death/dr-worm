
var ptr_game

func _ready():
	pass

func set_game_ptr(ptr):
	ptr_game = ptr

func set_pts(name, pts):
	var info = "";
	if name == "double": info = "DOUBLE!\n"
	if name == "tripple": info = "TRIPPLE!\n"
	if name == "rock": info = "ROCK!\n"
	info += "+" + str(pts)
	get_node("info").set_text(info)

func _on_anim_finished():
	ptr_game.remove_me(self)
	queue_free()
	
