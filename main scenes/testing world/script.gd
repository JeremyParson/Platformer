extends Node2D

#
onready var players = $Players

#
onready var safeTimer = $SafeTimer
onready var potatoTimer = $PotatoTimer
onready var pass_time_bonus = 3.0

#
onready var hud = $HUD

#
onready var explosionParticle = $EffectLayer/ExplosionParticle

#
var previous_carrier
var potato_carrier

#
func _ready():
	randomize()
	hud.timer = potatoTimer
	setup()
	start()

#
func setup ():
	potato_carrier = get_random_player()
	setup_carrier()

#
func start ():
	potatoTimer.start()

#
func end_game ():
	potatoTimer.stop()

#
func pass_potato (target=null):
	potato_carrier = target if target else get_random_player()
	setup_carrier()

#
func setup_carrier ():
	potato_carrier.has_potato = true
	potato_carrier.animationPlayer.play("highlight")
	potato_carrier.connect("body_coliision", self, "_on_Body_collision")

#
func get_random_player ():
	var count = players.get_child_count()
	if not count: return
	return players.get_child(randi() % count)

#
func _on_Body_collision (collider):
	if not collider.safeTimer.is_stopped(): return
	potato_carrier.has_potato = false
	potato_carrier.safeTimer.start()
	potato_carrier.animationPlayer.play("RESET")
	pass_potato (collider)

#
func _on_PotatoTimer_timeout():
	explosionParticle.global_position = potato_carrier.global_position
	potato_carrier.queue_free()
	explosionParticle.restart()
	
	if players.get_child_count() - 1 > 1:
		pass_potato()
	else:
		end_game()
