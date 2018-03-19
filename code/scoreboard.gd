var last_data

func _ready():
	last_data = get_scores()
	update_list()
	
func get_scores():
	var file = File.new()
	file.open(Globals.get("CONFIG/SCORES_FILE"), file.READ)
	var data = file.get_var()
	file.close()
	return data
	
func update_list():
	var string = ''
	last_data.sort_custom(self, "sorting")
	for line in range(0, 8):
		string = str(line+1) + '. ' + str(last_data[line][1]).pad_zeros(6) + ' ' + str(last_data[line][0])
		if line < 7: string += '\n'
		add_text(string)


func sorting(a, b):
	if a[1] > b[1]: return true
	else: return false