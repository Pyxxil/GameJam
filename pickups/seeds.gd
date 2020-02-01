extends Area2D

class_name Seeds

var taken = false

func _on_seeds_body_enter(body):
	if not taken and body is Player:
		(self.get_parent().get_parent().get_node("Help Text/SeedsHelpText") as RichTextLabel).set_visible(true)
		($Anim as AnimationPlayer).play("taken")
		taken = true
		(body as Player).pickup("Seeds")
