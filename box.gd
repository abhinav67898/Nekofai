extends RigidBody2D

var box_is_held := false

func pickup_box() -> void:
	box_is_held = true
	freeze = true
	
func drop_box() -> void:
	box_is_held = false
	freeze = true
	sleeping = false
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0 
