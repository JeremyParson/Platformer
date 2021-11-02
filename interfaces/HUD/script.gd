extends Control

#
onready var label = $TimeLabel
onready var timer : Timer

#
func _process(delta):
	label.text = str(round(timer.time_left))
