extends KinematicBody2D

var Logs = preload("res://pickups/Wood.tscn")

func cut_down():
	($Sprite as Sprite).set_visible(false)
	($CollisionShape2D as CollisionShape2D).call_deferred("set_disabled", true)
	(self.get_parent().get_node("SoundCut") as AudioStreamPlayer2D).play()
	var wood = Logs.instance()
	wood.position = self.global_position + Vector2(0, 20) # use node for shoot position
	get_parent().get_parent().add_child(wood) # don't want bullet to move with me, so add it as child of parent
