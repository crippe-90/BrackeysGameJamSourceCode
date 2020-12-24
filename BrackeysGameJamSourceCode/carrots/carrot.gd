extends Area2D


var hunger = null

func _ready():
	hunger = get_parent().get_parent().get_node("player").get_node("health_bar")
	
func _on_Area2D_body_entered(body):
	if(body.name == "player"):
		if(hunger.value + 10 >= hunger.FULL):
			hunger.value = hunger.FULL
		else:
			hunger.value += 10
		queue_free()
