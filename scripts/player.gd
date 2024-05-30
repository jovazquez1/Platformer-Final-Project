extends CharacterBody2D
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_coyote_jump = false  
var has_jumped = false  
@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var jump_sound = $JumpSound

func _ready():
	coyote_jump_timer.one_shot = true 

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if coyote_jump_timer.is_stopped():
			coyote_jump_timer.start()
	else:
		coyote_jump_timer.stop()
		can_coyote_jump = false
		has_jumped = false 
	if Input.is_action_just_pressed("jump") and (is_on_floor() or can_coyote_jump) and !has_jumped:
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		coyote_jump_timer.stop()
		can_coyote_jump = false
		has_jumped = true 
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0: 
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _on_coyote_jump_timer_timeout():
	can_coyote_jump = true

func _process(delta):
	if not is_on_floor() and !coyote_jump_timer.is_stopped():
		can_coyote_jump = true

