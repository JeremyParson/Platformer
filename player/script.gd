extends KinematicBody2D

signal body_coliision (collider)

export (int, 3) var controlling_player

onready var states = $States
onready var sprite = $Pivot/Sprite
onready var animationPlayer = $AnimationPlayer
onready var safeTimer = $SafeTimer

var facing : int
var has_potato = false

func _ready():
	states.initialize()

func _process(delta):
	var count = get_slide_count()
	if not count: return
	
	for i in count:
		var collision_info = get_slide_collision(i)
		if collision_info.collider is KinematicBody2D:
			emit_signal("body_coliision", collision_info.collider)
