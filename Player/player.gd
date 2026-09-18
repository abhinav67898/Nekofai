extends CharacterBody2D

# Movement settings
const SPEED := 200.0
const JUMP_VELOCITY := -450.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Left and right movement
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation()


func update_animation() -> void:
	# Airborne animations
	if not is_on_floor():
		if velocity.y < 0:
			# Moving upward
			sprite.play("jump")
		else:
			# Moving downward
			sprite.play("fall")

	# Ground animations
	elif abs(velocity.x) > 0.1:
		if velocity.x > 0:
			sprite.play("walk_forward")
		else:
			sprite.play("walk_backward")

	# Standing still
	else:
		sprite.play("idle")
