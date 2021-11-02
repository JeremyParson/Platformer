extends Node2D

#
onready var player1 = $Player1
onready var player2 = $Player2

#
onready var safeTimer = $SafeTimer
onready var potatoTimer = $PotatoTimer
onready var pass_time_bonus = 3.0

#
onready var hud = $HUD

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
func pass_potato (target=null):
	potato_carrier = target if target else get_random_player()
	setup_carrier()

#
func setup_carrier ():
	potato_carrier.animationPlayer.play("highlight")
	potato_carrier.connect("body_coliision", self, "_on_Body_collision")

#
func _on_Body_collision (collider):
	if not collider.safeTimer.is_stopped(): return
	potato_carrier.safeTimer.start()
	potato_carrier.animationPlayer.play("RESET")
	pass_potato (collider)

#
func get_random_player ():
	return [player1, player2][randi() % 2]
