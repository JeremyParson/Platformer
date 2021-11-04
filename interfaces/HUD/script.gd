extends Control

#
onready var label = $TimeLabel
onready var timer : Timer

#
func _process(delta):
	var time_left = ceil(timer.time_left)
	label.text = str(time_left)
	if time_left <= 10: label.set("custom_colors/font_color", Color.red)
	if time_left >= 30: label.set("custom_colors/font_color", Color.whitesmoke)
