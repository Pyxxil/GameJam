extends KinematicBody2D

func cut_down():
	($Sprite as Sprite).set_visible(false)
	($CollisionShape2D as CollisionShape2D).call_deferred("set_disabled", true)
	(self.get_parent().get_node("SoundCut") as AudioStreamPlayer2D).play()
