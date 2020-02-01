extends Area2D

class_name Seeds


var taken = false
var Seed = preload("res://player/Seed.tscn")

const BULLET_VELOCITY = 1000

func _on_coin_body_enter(body):
	if not taken and body is Player:
		($Anim as AnimationPlayer).play("taken")
		taken = true
		(body as Player).pickup(Seed)
