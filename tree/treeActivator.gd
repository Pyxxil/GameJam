extends StaticBody2D

onready var tree = self.get_parent().get_node("KinematicBody2D/Sprite") as Sprite
onready var collision = self.get_parent().get_node("KinematicBody2D/CollisionShape2D") as CollisionShape2D

func plant_seed():
	tree.set_visible(true)
	collision.call_deferred("set_disabled", false)

