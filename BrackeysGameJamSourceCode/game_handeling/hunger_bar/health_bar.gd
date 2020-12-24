extends TextureProgress

export (Vector2) var offset = Vector2.ZERO

export (Color) var healthy = Color.green
export (Color) var cautious = Color.yellow
export (Color) var danger = Color.red

var cautios_limit = .5
var danger_limit = .2

var timer = null
const FULL = 100.0
export var hunger = 2

var counter = 0.0

var player = null

func _ready():
	player = get_parent()
	self.value = FULL	
	self.set_as_toplevel(true)
	
func _process(delta):
	rect_global_position = player.global_position + offset
	counter += delta
	if(counter >= 1):
		self.value -= (counter * hunger)
		counter = 0	
	_color(self.value)
	
func _color(h):
	if(h < danger_limit * FULL):
		tint_progress = danger
	elif(h < cautios_limit* FULL):
		tint_progress = cautious
	else:
		tint_progress = healthy
		
			
	
