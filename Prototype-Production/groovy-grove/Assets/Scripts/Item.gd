extends Node2D

@onready var interaction_area = $InteractableArea

@export var item_name = "Plant"
@export var item_scene: PackedScene

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact(player):

	var packed_scene = load(scene_file_path)

	player.pickup_item(item_name, packed_scene)

	queue_free()
