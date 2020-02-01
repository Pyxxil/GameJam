extends RigidBody2D

class_name Build

func _on_Timer_timeout():
	self.queue_free()

func _on_Build_body_entered(body):
	if body.has_method("repair"):
		body.call("repair")
