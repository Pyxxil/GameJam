extends Node2D

func _ready():
	$RepairedBridge/Repaired.set_visible(false)
	($RepairedBridge/CollisionShape2D as CollisionShape2D).set_disabled(true)
