extends Label

var current_lap = 1
var target_laps = 5

var passed_checkpoint = false

onready var FinishLine = get_node("/root/Course/FinishLine")
onready var Checkpoint = get_node("/root/Course/Checkpoint")

func _on_FinishLine_body_entered(body):
	
	if FinishLine.orientation.x == 0:
		if (body.speed.sign().y == FinishLine.orientation.y) and passed_checkpoint:
			current_lap += 1
			passed_checkpoint = false
			set_text("Lap " + str(current_lap))
	else:
		if (body.speed.sign().x == FinishLine.orientation.x) and passed_checkpoint:
			current_lap += 1
			passed_checkpoint = false
			set_text("Lap " + str(current_lap))
		
	if current_lap >= target_laps:
		get_parent().get_node("Timer").stop_timer()
		set_text("FINISHED! Press R to try again!")

func _on_Checkpoint_body_entered(body):
	
	if FinishLine.orientation.x == 0:
		if (body.speed.sign().y == Checkpoint.orientation.y):
			passed_checkpoint = true
	else:
		if (body.speed.sign().x == Checkpoint.orientation.x):
			passed_checkpoint = true
