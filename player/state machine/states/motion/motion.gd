extends "../state.gd"

var velocity : Vector2 = Vector2.ZERO
export var move_speed = 2000.0
export var max_speed = 250.0

var UP : Vector2 = Vector2.UP
var SNAP : Vector2
var FRICTION : float = .28

#
func initialize (args):
	velocity = args[0]

#
func update (delta):
	set_facing(clamp(velocity.x, -1, 1))
	velocity = velocity.clamped(max_speed)
	
	velocity = owner.move_and_slide(velocity)
	

# returns a vector containing vertical and horizontal direction inputs
func get_input ():
	var plyr_num = owner.controlling_player
	var h_input = Input.get_action_strength(str("right_p", plyr_num)) - Input.get_action_strength(str("left_p", plyr_num))
	var v_input = Input.get_action_strength(str("down_p", plyr_num)) - Input.get_action_strength(str("up_p", plyr_num))
	return Vector2(h_input, v_input)

# change the players facing
func set_facing (direction):
	if direction and owner.facing != direction:
		owner.facing = direction
		owner.sprite.flip_h = direction == -1
