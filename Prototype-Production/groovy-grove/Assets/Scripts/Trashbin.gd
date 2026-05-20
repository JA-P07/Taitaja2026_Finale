extends Node

@onready var interaction_area: InteractableArea = $InteractableArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact(player):
	if player.is_holding and player.held_item_instance.is_in_group("trash"):

		player.held_item_instance.queue_free()

		player.held_item_instance = null
		player.held_item_name = ""
		player.is_holding = false
		print("item put to the trash");
