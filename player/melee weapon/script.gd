extends Position2D

#
export (Resource) var _weapon_data

#
enum debug_directions {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

#
export (bool) var debug_swing = false
export (debug_directions) var debug_swing_direction

#
onready var debug_direction_map = {
	debug_directions.UP : Vector2.UP,
	debug_directions.DOWN : Vector2.DOWN,
	debug_directions.LEFT : Vector2.LEFT,
	debug_directions.RIGHT : Vector2.RIGHT
}

#
export (int) var swing_offset = 45
export (float) var swing_duration = 3

#
onready var sprite = $Sprite
onready var hitBox = $HitBox
onready var collisionShape2D = $HitBox/CollisionShape2D
onready var cooldownTimer = $CooldownTimer
onready var tween = $Tween
onready var particles2D = $Particles2D

#
var durability : int = 0
var is_broken : bool = false
var knockback : int = 0
var facing : Vector2 = Vector2.UP

#
func _ready():
	visible = false
	if _weapon_data:
		initialize(_weapon_data)

#
func _process(delta):
	if debug_swing:
		debug_swing = false
		swing(debug_direction_map[debug_swing_direction])

#
func initialize (weapon_data : Weapon):
	_weapon_data = weapon_data
	durability = _weapon_data.durability
	sprite.texture = _weapon_data.image
	knockback = _weapon_data.knockback
	collisionShape2D.shape.extents = _weapon_data.image.get_size() / 2

#
func swing (direction : Vector2):
	var attack_angle = rad2deg(facing.angle_to(direction))
	rotation_degrees = attack_angle - swing_offset
	visible = true
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_degrees + (swing_offset * 2), swing_duration)
	tween.interpolate_property(particles2D.process_material, "angle", -rotation_degrees, -(rotation_degrees + (swing_offset * 2)), swing_duration)
	tween.start()

#
func _on_HitBox_body_entered(body):
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	pass # Replace with function body.
