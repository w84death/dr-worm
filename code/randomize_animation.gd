# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

func _ready():
	randomize()
	var r = rand_range(0, self.get_current_animation_length())
	self.seek(r)
