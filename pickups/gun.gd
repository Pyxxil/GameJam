extends Area2D

class_name Gun

var taken = false

func _on_coin_body_enter(body):
	if not taken and body is Player:
		($Anim as AnimationPlayer).play("taken")
		(self.get_parent().get_parent().get_node("Help Text/GunHelpText") as RichTextLabel).set_visible(true)
		taken = true
		(body as Player).pickup("Gun")
