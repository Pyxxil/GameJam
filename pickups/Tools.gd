extends Area2D

class_name Tools

var taken = false

func _on_Tools_body_entered(body):
	if not taken and body is Player:
		(self.get_parent().get_node("ToolsHelpText") as RichTextLabel).set_visible(true)
		($Anim as AnimationPlayer).play("taken")
		taken = true
		(body as Player).pickup("Tools")
