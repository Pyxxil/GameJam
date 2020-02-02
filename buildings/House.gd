extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	($FixedHouse as Sprite).set_visible(false)
	($TopPlatform/CollisionShape2D as CollisionShape2D).set_disabled(true)
	($LeftSidePlatform/CollisionShape2D as CollisionShape2D).set_disabled(true)
