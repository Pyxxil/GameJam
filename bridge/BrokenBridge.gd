extends StaticBody2D

func repair_bridge():
	self.set_visible(false)
	(self.get_parent().get_node("RepairedBridge/Repaired") as Sprite).set_visible(true)
	(self.get_parent().get_node("RepairedBridge/CollisionShape2D") as CollisionShape2D).call_deferred("set_disabled", false)
