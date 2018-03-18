# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

var time_max = 8
var time_min = 0

func set_time_left(time_left):
	if Globals.get("GAME/DIFFICULTY") > 0:
		time_left = floor(time_left * 2)
	get_node("time").set_frame(time_max-time_left)
