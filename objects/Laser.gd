extends Area2D

var direction := Vector2(0,-1)
var projectile_speed := 1000

func _process(delta:float) -> void:
	self.position += direction * projectile_speed * delta


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
	


func _on_Laser_body_entered(body) -> void:
	if (!self.is_queued_for_deletion() && body.is_in_group("asteroids")):
		print("asteroid hit")
		body.call_deferred("explode")
		get_parent().remove_child(self)
		queue_free()

