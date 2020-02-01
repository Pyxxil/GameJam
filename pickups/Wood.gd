extends Area2D

class_name Wood

var taken = false

func _on_Wood_body_entered(body):
	if not taken and body is Player:
		($Anim as AnimationPlayer).play("taken")
		taken = true
		(body as Player).pickup("Wood")
