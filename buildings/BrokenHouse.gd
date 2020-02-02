extends StaticBody2D

func repair():
	self.set_visible(false)
	($CollisionShape2D as CollisionShape2D).call_deferred("set_disabled", true)
	(self.get_parent().get_node("FixedHouse") as Sprite).set_visible(true)
	(self.get_parent().get_node("LeftSidePlatform/CollisionShape2D") as CollisionShape2D).call_deferred("set_disabled", false)
	(self.get_parent().get_node("TopPlatform/CollisionShape2D") as CollisionShape2D).call_deferred("set_disabled", false)
	get_parent().get_parent().get_parent().get_node("Player").use_wood()
