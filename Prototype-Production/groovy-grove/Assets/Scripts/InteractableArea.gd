extends Area2D
class_name InteractableArea

@export var action_name: String = "INTERACT"

var interact: Callable = func(player):
	pass


func _on_body_entered(body):
	if body.is_in_group("Players"):
		InteractionManager.register_area(self, body)


func _on_body_exited(body):
	if body.is_in_group("Players"):
		InteractionManager.unregister_area(self, body)
