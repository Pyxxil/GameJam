extends StaticBody2D

func repair():
	if self.is_visible():
		(get_parent().get_parent().get_parent().get_node("Player") as Player).use_wood()
		self.set_visible(false)
		(self.get_parent().get_node("RepairedBridge/Repaired") as Sprite).set_visible(true)
		(self.get_parent().get_node("RepairedBridge/CollisionShape2D") as CollisionShape2D).call_deferred("set_disabled", false)
		(get_parent().get_parent().get_parent().get_node("Player") as Player).think("I wish fixing my life was that easy")
