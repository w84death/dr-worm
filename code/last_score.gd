extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_text(str(Globals.get("GAME/LAST_SCORE")))