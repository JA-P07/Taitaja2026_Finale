extends Node

@onready var interaction_area: InteractableArea = $InteractableArea
@onready var label = $Label;

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact(player):
	if player.is_holding and InteractionManager.tasksDone >= 9:
		InteractionManager.tasksDone += 0.5
		print("Players win");
	else:
		label.text = "Complete all the tasks first!!"
