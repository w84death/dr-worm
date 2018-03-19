# KISS ARCADE ENGINE for Godot Engine 2.x
# ---------------------------------------
# (c)2018 kj/P1X 
# http://p1x.in | krzysztofjankowski.com

func _ready():
	set_globals()
	var file = File.new()
	if not file.file_exists(Globals.get("CONFIG/SCORES_FILE")): init_scores()
	go_to_menu()

func set_globals():
	Globals.set("GAME/VERSION", "BETA 3")
	
	Globals.set("CONFIG/WIDTH", 160)
	Globals.set("CONFIG/HEIGHT", 150)
	Globals.set("CONFIG/HALF_WIDTH", 100)
	Globals.set("CONFIG/LEFT_MARGIN", 24)
	Globals.set("CONFIG/SCORES_FILE", "user://high_scores.p1x")
	
	Globals.set("GAME/MAP_TYPE", 0)
	Globals.set("GAME/BONUS_TO_HEALTH", 3)
	Globals.set("GAME/DEADLINE_TIME_SEC", 4)
	Globals.set("GAME/PLAYER_HP_ON_START", 3)
	Globals.set("GAME/DIFFICULTY", 0)
	Globals.set("GAME/DIFF_EASY_TIME_SEC", 8)
	Globals.set("GAME/DIFF_HARD_TIME_SEC", 4)
	Globals.set("GAME/DIFF_EASY_SCORE_BONUS", 1)
	Globals.set("GAME/DIFF_HARD_SCORE_BONUS", 100)
	Globals.set("GAME/LAST_SCORE", 0)
	Globals.set("GAME/DOPAMINE_TIME_SEC", 10)
	
	Globals.set("GAME/SCORE/pill", 8)
	Globals.set("GAME/SCORE/double", 32)
	Globals.set("GAME/SCORE/tripple", 128)
	Globals.set("GAME/SCORE/3pills", 64)
	Globals.set("GAME/SCORE/dopamine", 32)
	Globals.set("GAME/SCORE/rock", 2)

func go_to_menu():
	get_tree().change_scene("res://scenes/menu.tscn")

func init_scores():
	var file = File.new()
	var data = [
		['P1X',1000],
		['P1X',500],
		['P1X',250],
		['P1X',100],
		['P1X',75],
		['P1X',50],
		['P1X',25],
		['P1X',10],
		['P1X',5]]
	
	file.open(Globals.get("CONFIG/SCORES_FILE"), File.WRITE)
	file.store_var(data)
	file.close()
	
# __________
# CHANGE_LOG___
# 
# _____
# TODO_(beta4)___
# - hiscore entering 
# - combos (double 3x)
#
# _________
# RELEASED___
#
# beta3___
# - hiscore system
# - scoreboard scene
# - placeholder nick saving scene
# - balancing game / new score system
# - help scene
#
# beta2___
# - pimped menus (logo/bg)
# - game sfx
# - mirrored bacgrounds
#
# beta1___
# - bonus panel working  
# - coins to collect
# - 3x same bonus = coins mode
# - removed visual timer
# - deadline generates obstacle (rock) on safezone
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