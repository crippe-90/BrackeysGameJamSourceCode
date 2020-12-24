extends RichTextLabel
var microseconds = 0
var seconds = 0
var minutes = 0

export var counter = 0.0 
export var offset = Vector2.ZERO

var timer_text = ""

func _process(delta):
	counter -= 100*delta
	microseconds = int(counter)
	seconds = microseconds
	minutes = seconds
	self.set_global_position(get_parent().global_position + offset)	
	timer_text = str(int(minutes/(60*100))) + ":" + str(int(seconds/100)%60) + ":" + str(int(microseconds)%100) 
	set_text(timer_text)

