extends CharacterBody2D

# Movement settings
const SPEED := 200.0
const JUMP_VELOCITY := -450.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickupArea: Area2D = $PickupArea
var held_box: RigidBody2D = null

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
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody2D:
			collider.apply_central_impulse(-collision.get_normal() * 20.0)
			
	handlePickup()
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
		
		
# Box Pickup function
func handlePickup() -> void:
	if not Input.is_action_just_pressed("pickup"):
		return
		
	if held_box != null: 
		held_box.global_position = global_position + Vector2(0,-20)
		held_box.drop_box()
		held_box = null
		print("Box Dropped")
		return
	
	for body in pickupArea.get_overlapping_bodies():
		if body is RigidBody2D and body.has_method("pickup_box"):
			held_box = body
			held_box.pickup_box()
			held_box.global_position = global_position + Vector2(0, -10)
			break
			
