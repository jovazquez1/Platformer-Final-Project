extends Node2D
const SPEED = 60
var direction = 1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var slime_bounce = $SlimeBounce

func _process(delta):
	if ray_cast_right.is_colliding():
		slime_bounce.play()
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		slime_bounce.play()
		direction = 1 
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
