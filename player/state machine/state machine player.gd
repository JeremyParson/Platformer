extends "state machine.gd"

func _change_state (state_name):
	if state_name in ["move", "idle"]:
		states_map[state_name].initialize([current_state.velocity])
		
	._change_state(state_name)
