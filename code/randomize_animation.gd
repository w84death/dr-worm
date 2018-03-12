func _ready():
	randomize()
	var r = rand_range(0, self.get_current_animation_length())
	self.seek(r)
