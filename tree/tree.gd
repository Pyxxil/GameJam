extends Node

onready var tree = ($KinematicBody2D/Sprite as Sprite)
onready var collision = ($KinematicBody2D/CollisionShape2D as CollisionShape2D)

func _ready():
	print(collision.disabled)
	tree.set_visible(false)
	collision.set_disabled(true)
	print(collision.disabled)
