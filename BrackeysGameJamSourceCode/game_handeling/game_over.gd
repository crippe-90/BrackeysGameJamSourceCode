extends Sprite

var timer = null

func _ready():
	timer = get_child(1)
	
func _process(delta):
	if(timer.counter <= 0):
		game_management.load_level()
