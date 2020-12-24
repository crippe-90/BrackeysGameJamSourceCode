extends Area2D

var level_completed = false

func _ready():
	level_completed = false

func _on_Area2D_body_entered(body):
	if body.name == "player":
		if(!level_completed):
			level_completed = true
			game_management.level_completed()
			game_management.load_level()
