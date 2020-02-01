extends RigidBody2D

class_name Seed

func _on_seed_body_entered(body):
	if body.has_method("plant_seed"):
		body.call("plant_seed")

func _on_Timer_timeout():
	($Anim as AnimationPlayer).play("shutdown")
