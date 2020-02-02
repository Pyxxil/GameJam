extends StaticBody2D

var grown_count = 0

func plant_seed():
	(self.get_parent().get_node("KinematicBody2D/Sprite") as Sprite).set_visible(true)
	(self.get_parent().get_node("KinematicBody2D/CollisionShape2D") as CollisionShape2D).call_deferred("set_disabled", false)
	(self.get_parent().get_node("SoundGrow") as AudioStreamPlayer2D).play()
	(self.get_parent().get_parent().get_parent().get_node("Player") as Player).grow_tree()
	grown_count += 1
	if grown_count == 2:
		(self.get_parent().get_parent().get_parent().get_node("Player") as Player).think("Another decade wasted waiting for that tree to grow...")

