extends KinematicBody2D

var explosion_player_scene := load("res://objects/ParticlesPlayerExplosion.tscn")

signal laser_shoot
signal player_died

const SPEED: = 600

func _physics_process(delta: float) -> void:
		var velocity := Vector2()

		velocity.x = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))) * SPEED
		velocity.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) * SPEED

		move_and_collide(velocity * delta)

func _explode():
	var explosion_particles = explosion_player_scene.instance()
	explosion_particles.position = self.position
	get_parent().add_child(explosion_particles)
	explosion_particles.emitting = true
	emit_signal("player_died")
	queue_free()

func _ready() -> void:
	var camera = get_parent().get_node("MainCamera")
	self.connect("laser_shoot", camera, "_on_Player_laser_shoot")

	var game = get_parent()
	self.connect("player_died", game, "_on_Player_player_died")

func _unhandled_key_input(event: InputEventKey) -> void:
	if (event.is_action_pressed("shoot")):
		$LaserWeapon.shoot()
		emit_signal("laser_shoot")

func _on_Hitbox_body_entered(body):
	if (!self.is_queued_for_deletion() && body.is_in_group("asteroids")):
		_explode()


