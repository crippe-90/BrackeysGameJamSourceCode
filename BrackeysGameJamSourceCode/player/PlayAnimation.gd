extends AnimatedSprite

var idle_right = "idle_right"
var idle_left = "idle_left"
var walk_left = "walk_left"
var walk_right = "walk_right"
var jump_right = "jump_right"
var jump_left = "jump_left"
var initialize_jump_left = "initialize_jump_left"
var initialize_jump_right = "initialize_jump_right"

var player = null
var jump_sound = null

var jump_not_done = false

func _ready():
	player = get_parent()
	jump_sound = get_parent().get_node("AudioStreamPlayer2D")
	jump_not_done = false
	
	
func _process(delta):
	if(player.on_floor):
		if(player.jump_button_pressed):
			jump_not_done = true
			if(player.last_button_was_left):
				$".".play(initialize_jump_left)
			elif(player.last_button_was_right):
				$".".play(initialize_jump_right)
			else:
				play_animations()
		else:
			play_animations()
	else:
		if(player.jump_button_realesed):
			play_jump_animation()
			
			
		
func play_jump_animation():
	if(jump_not_done):
		jump_not_done = false
		if(player.last_button_was_left):
			$".".play(jump_left)
			jump_sound.play_sound()
		else:
			$".".play(jump_right)
			jump_sound.play_sound()
	else:
		play_animations()

func play_animations():
	if(player.left):
		$".".play(walk_left)
	elif(player.right):
		$".".play(walk_right)
	elif(player.idle_right):
		$".".play(idle_right)
	else:
		$".".play(idle_left)
	
func _on_AnimatedSprite_animation_finished():
	if animation == jump_right or animation == jump_left:
		jump_not_done = false
