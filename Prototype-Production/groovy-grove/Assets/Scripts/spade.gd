extends Node2D

@onready var interaction_area = $InteractableArea

@export var item_name = "spade"
@export var item_instance: Node2D

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact(player):

	self.add_to_group("spade");
	player.pickup_item(item_name, self)
	print("HOLDING:", player.is_holding)
	print("ITEM:", player.held_item_name)
