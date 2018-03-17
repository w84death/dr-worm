# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

func _ready():
	set_globals()
	go_to_menu()

func set_globals():
	Globals.set("GAME/VERSION", "BETA 1")
	
	Globals.set("CONFIG/WIDTH", 160)
	Globals.set("CONFIG/HEIGHT", 150)
	Globals.set("CONFIG/HALF_WIDTH", 100)
	Globals.set("CONFIG/LEFT_MARGIN", 24)
	
	Globals.set("GAME/MAP_TYPE", 0)
	Globals.set("GAME/BONUS_TO_HEALTH", 3)
	Globals.set("GAME/DEADLINE_TIME_SEC", 4)
	Globals.set("GAME/PLAYER_HP_ON_START", 3)
	Globals.set("GAME/DIFFICULTY", 0)
	Globals.set("GAME/DIFF_EASY_TIME_SEC", 6)
	Globals.set("GAME/DIFF_HARD_TIME_SEC", 2)
	Globals.set("GAME/DIFF_EASY_SCORE_BONUS", 1)
	Globals.set("GAME/DIFF_HARD_SCORE_BONUS", 100)
	Globals.set("GAME/LAST_SCORE", 0)
	Globals.set("GAME/DOPAMINE_TIME_SEC", 10)


func go_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")

# __________
# CHANGE_LOG___
# 
# _____
# TODO___
# - scoreboard scene
# - hiscore entering 
# _________
# RELEASED___
#
# beta1___
# - bonus panel working  
# - coins to collect
# - 3x same bonus = coins mode
# - 
#
# alpha8___
# - new bonuses sprites
# - panel shows bonus load
# - terrain changes colour by pills
# - menu sounds
# - background music
# - animated menus
# - new menu sprites
# - new in game GUI
#
# alpha7___
# - deadline time
# - 3 pills to grow
# - pills and enemy timebased spawners
#
# alpha6___
# - snake tail physics
#