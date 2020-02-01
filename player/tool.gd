extends RigidBody2D

class_name Tool

func _on_Timer_timeout():
	self.queue_free()

func _on_Tool_body_entered(body):
	if body.has_method("repair_bridge"):
		body.call("repair_bridge")
