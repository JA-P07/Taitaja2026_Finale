extends Node2D

@onready var interaction_area = $InteractableArea

@export var item_name = "trash"
@export var item_instance: Node2D
@export var interact_sound: AudioStream

func _play_interact_sound() -> void:
	if not interact_sound:
		return
	var audio = AudioStreamPlayer.new()
	audio.stream = interact_sound
	get_tree().root.add_child(audio)
	audio.play()
	audio.connect("finished", Callable(audio, "queue_free"))

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact(player):
	_play_interact_sound()
	self.add_to_group("trash")
	player.pickup_item(item_name, self)
	print("HOLDING:", player.is_holding)
	print("ITEM:", player.held_item_name)
