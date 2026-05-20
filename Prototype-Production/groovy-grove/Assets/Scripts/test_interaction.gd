extends Node

@onready var interaction_area: InteractableArea = $interactable

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	print("interacteddd!");
