extends KinematicBody2D

const SPEED: = 600

func _physics_process(delta: float) -> void:
		var velocity := Vector2()

		velocity.x = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))) * SPEED
		velocity.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) * SPEED

		move_and_collide(velocity * delta)

func _unhandled_key_input(event: InputEventKey) -> void:
	if (event.is_action_pressed("shoot")):
		$LaserWeapon.shoot()
