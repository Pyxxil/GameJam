extends KinematicBody2D

class_name Fire

var anim = ""

const STATE_BURNING = 0
const STATE_EXTINGUISHED = 1

var state = STATE_BURNING

onready var sprite = $Sprite

func _physics_process(_delta):
	var new_anim = "idle"

	if state == STATE_BURNING:
		new_anim = "walk"
	else:
		new_anim = "explode"

	if anim != new_anim:
		anim = new_anim
		($Anim as AnimationPlayer).play(anim)

func hit_by_bullet():
	state = STATE_EXTINGUISHED
