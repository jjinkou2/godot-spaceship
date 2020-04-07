extends "res://objects/Asteroid.gd"

func explode():
	if (is_explode):
		return
	is_explode = true
	_explosion_particles()
	_play_explosion_sound()
	emit_signal("explode")
	get_parent().remove_child(self)
	queue_free() 
func _ready() -> void:
	var main_camera = get_node("/root/Game/MainCamera")
	self.connect("explode", main_camera, "asteroid_small_exploded")
