extends KinematicBody2D

# How fast the player speeds up
var power = 1200
# How fast the player slows down if you don't press anything
var slowdown = 1.01
# The player can't go any faster than this
var max_speed = 30000

# How fast it's currently going
var speed = Vector2.ZERO
# Where it's currently being "pushed"
var push = Vector2.ZERO

func get_input():
	
	# Reseting push after every frame
	push = Vector2.ZERO
	
	# Set push acording to input
	if Input.is_action_pressed("ui_right"):
		push.x = 1
	if Input.is_action_pressed("ui_left"):
		push.x = -1
	if Input.is_action_pressed("ui_down"):
		push.y = 1
	if Input.is_action_pressed("ui_up"):
		push.y = -1
	if Input.is_action_just_pressed("restart"):
		restart_run()
	

func _physics_process(delta):
	
	get_input()
	
	# Normalize push vector
	push = push.normalized()
	
	# Apply push
	if push.x != 0:
		speed.x = speed.x + (push.x * power)
	# Apply slowdown if nothing is pressed
	else:
		speed.x = speed.x / (slowdown)
	
	# Same thing with the Y axis
	if push.y != 0:
		speed.y = speed.y + (push.y * power)
	else:
		speed.y = speed.y / (slowdown)
	
	# Change speed to the maximum if ever exeded
	if speed.x > max_speed:
		speed.x = max_speed
	if speed.x < -max_speed:
		speed.x = -max_speed
		
	if speed.y > max_speed:
		speed.y = max_speed
	if speed.y < -max_speed:
		speed.y = -max_speed
	
	# Move character
	move_and_slide(speed * delta)
	
	# Slow down Player when they collide with something
	if get_slide_count() != 0:
		speed = Vector2.ZERO

func restart_run():
	position = get_parent().get_node("FinishLine").position
	$Text/Timer.elapsed = 0
	$Text/Timer.running = true
	$Text/LapCounter.current_lap = 1
	speed = Vector2.ZERO
