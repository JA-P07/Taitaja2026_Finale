extends Node

@onready var interaction_area: InteractableArea = $InteractableArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	print("interacted with plant, destroying plant");
	self.queue_free();
