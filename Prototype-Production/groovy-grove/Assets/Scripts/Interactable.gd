extends Node
class_name InteractableArea

@export var action_name: String = "INTERACT"

var interact: Callable = func():
	print("interacted!")
	pass


func _on_body_entered(body):
	InteractionManager.register_area(self)


func _on_body_exited(body):
	InteractionManager.unregister_area(self)
