extends Node


const level1 = "res://levels/level1.tscn"
const level2 = "res://levels/level_prefab.tscn"
const level3 = ""
const game_completed ="res://game_handeling/game_completed.tscn"

var current_level_index = 0

func load_level():
	if current_level_index == 0:
		get_tree().change_scene(level1)
	elif current_level_index == 1:
		get_tree().change_scene(level2)

func level_completed():
	game_management.current_level_index += 1


