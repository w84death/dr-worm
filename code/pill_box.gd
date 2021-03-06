extends VBoxContainer

var stack = [0,0,0]
onready var pills = [
	get_node("0"),
	get_node("1"),
	get_node("2")
]
var last_pill = -1
var ptr_game

func _ready():
	refresh_box()

func set_game_ptr(ptr):
	ptr_game = ptr
	
func reset_box():
	stack = [0,0,0]
	get_node("anim").play("reset")
	
func add_pill(id):
	stack.append(id+1)
	stack.remove(0)
	refresh_box()
	calculate_bonus(id)
	
func refresh_box():
	for i in range(0, stack.size()):
		pills[i].get_node("body").set_frame(stack[i])
	
func _on_anim_finished():
	refresh_box()
	
func is_perfect():
	if stack[0] > 0 and stack[0] == stack[1] and stack[1] == stack[2]: 
		return true
	return false
	
func calculate_bonus(id):
	if is_perfect(): ptr_game.score_increment("tripple")
	else:
		if last_pill == id: ptr_game.score_increment("double")
		else: 
			ptr_game.score_increment("pill")
	last_pill = id
