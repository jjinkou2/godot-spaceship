extends RigidBody2D

var is_explode := false

func explode():
	if (is_explode):
		return
	is_explode = true
	
	get_parent().remove_child(self)
	queue_free() 
