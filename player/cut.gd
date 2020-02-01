extends RigidBody2D

class_name Cut

func _on_Timer_timeout():
	self.queue_free()

func _on_Cut_body_entered(body):
	if body.has_method("cut_down"):
		body.call("cut_down")
