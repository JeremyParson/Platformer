extends Node

# when current_state changes state_changed is emitted
signal state_changed (new_state, old_state)

#
export(NodePath) var START_STATE

#
onready var states_map = {
	"move": $Move,
	"idle": $Idle,
	"stun": $Stun,
}

#
var _active = false

#
var state_stack = []

#
var current_state

#
func _ready ():
	for state in get_children():
		state.connect("finished", self, "_change_state")
		

#
func _process (delta):
	if not _active: return
	current_state.update(delta)

#
func _input (event):
	if not _active: return
	current_state.handle_input(event)

#
func initialize ():
	set_active(true)
	state_stack.push_front(get_node(START_STATE))
	current_state = state_stack[0]
	current_state.enter()
	

#
func set_active (value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	
	if not _active:
		state_stack = []
		current_state = null

#
func _change_state (state_name):
	
	current_state.exit()
	
	if state_name == "previous":
		state_stack.pop_front()
	
	elif state_name in ["hurt"]:
		state_stack.push_front(states_map[state_name])
	
	else:
		state_stack[0] = states_map[state_name]
	
	emit_signal("state_changed", state_stack[0], current_state)
	
	current_state = state_stack[0]
	
	if state_name != "previous":
		current_state.enter()

#
func _on_Animation_finished (animation):
	if not _active: return
	current_state._on_Animation_finished(animation)

#
func _on_Tween_completed (object, key):
	if not _active: return
	current_state._on_Tween_completed(object, key)
	
