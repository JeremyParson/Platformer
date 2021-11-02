extends "../motion.gd"

func update (delta):
	var input = get_input()
	
	if input == Vector2.ZERO:
		emit_signal("finished", "idle")
	
	velocity += input * move_speed * delta
	
	if not input.x:
		velocity.x = lerp(velocity.x , 0, FRICTION)
	
	if not input.y:
		velocity.y = lerp(velocity.y , 0, FRICTION)
	
	.update(delta)
