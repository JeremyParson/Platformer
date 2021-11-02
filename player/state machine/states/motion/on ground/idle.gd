extends "../motion.gd"

func update (delta):
	if get_input() != Vector2.ZERO:
		emit_signal("finished", "move")
	
	velocity.x = lerp(velocity.x , 0, FRICTION)
	velocity.y = lerp(velocity.y , 0, FRICTION)
	
	.update(delta)
