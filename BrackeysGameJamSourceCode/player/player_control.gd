extends KinematicBody2D


#Jump 
export var fall_gravity_scale := 100.0
export var low_jump_gravity_scale := 70.0
export var jump_power := 500.0
var jump_button_pressed = false
var jump_button_realesed = false

#Physics
var velocity = Vector2()
var earth_gravity = 9.807 # m/s^2
export var gravity_scale := 60.0
export var friction = 420.0
var on_floor = false

#Other movement
export var movement_speed = 800.0
export var max_speed = 800
export var max_air_speed = 900.0
export var air_movement_speed = 700.0
var left = false
var right = false

#In game constraints 
export var death_value_y = -500

#Game controls
var dead = false
var idle_right = true
var last_button_was_left = false
var last_button_was_right = true
var hunger = null

func _ready():
	idle_right = true
	dead = false
	jump_button_pressed = false
	jump_button_realesed = false
	last_button_was_left = false
	last_button_was_right = true
	hunger = get_node("health_bar")
	
func get_input():
	left = false
	right = false
	jump_button_realesed = false
	if(Input.is_action_pressed("ui_right")):
		right = true
		idle_right = true
		last_button_was_right = true
		last_button_was_left = false
	elif(Input.is_action_pressed("ui_left")):
		left = true
		idle_right = false
		last_button_was_left = true
		last_button_was_right = false
	if(Input.is_action_just_pressed("ui_accept")):
		jump_button_pressed = true
		jump_button_realesed = false
		movement_speed = 700		
	elif(Input.is_action_just_released("ui_accept")):
		jump_button_realesed = true
		jump_button_pressed = false
		movement_speed = 1000
	

func physics_calculations(delta):
	#gravity
	velocity += Vector2.DOWN * earth_gravity * gravity_scale * delta
	if velocity.y > 0: 
		velocity += Vector2.DOWN * earth_gravity * fall_gravity_scale * delta
	elif velocity.y <= 0:
		velocity += Vector2.DOWN * earth_gravity * low_jump_gravity_scale * delta 
	#friction
	if((velocity.x) > 2):
		velocity += Vector2.LEFT * friction*delta
	elif(velocity.x < -2):
		velocity += Vector2.RIGHT*friction*delta
	else:
		velocity = Vector2(0, velocity.y)
		
func control_movement(var delta):
	if on_floor:
		if left:
			if(abs(velocity.x)<max_speed):
				velocity += Vector2.LEFT * movement_speed * delta
		elif right:
			if(abs(velocity.x)<max_speed):
				velocity +=Vector2.RIGHT * movement_speed * delta
	else:
		if left:
			if(abs(velocity.x)<max_air_speed):
				velocity += Vector2.LEFT * air_movement_speed * delta
		elif right:
			if(abs(velocity.x)<max_air_speed):
				velocity +=Vector2.RIGHT * air_movement_speed * delta
	
	if jump_button_realesed:
		jump_button_realesed = true
		if on_floor:
			velocity += Vector2.UP * jump_power
			

func die():
	dead = true
	game_management.load_level()
	
func _physics_process(delta):
	if position.y > death_value_y:
		die()
	else:	
		get_input()
		physics_calculations(delta)
		control_movement(delta)
		velocity = move_and_slide(velocity, Vector2.UP) 
		if is_on_floor(): 
			on_floor = true
		else:
			on_floor = false

func _process(delta):
	if(hunger.value <= 0):
		die()
	
	
