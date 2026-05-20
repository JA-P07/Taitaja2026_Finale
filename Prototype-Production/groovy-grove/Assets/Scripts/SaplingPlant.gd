extends Node

@onready var interaction_area: InteractableArea = $InteractableArea

var players_in_area: Array = []

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_body_entered(body):
	if body.is_in_group("Players"):
		players_in_area.append(body)

func _on_body_exited(body):
	if body.is_in_group("Players"):
		players_in_area.erase(body)


func _on_interact(player):

	if players_in_area.size() < 2:
		print("Both players need to be here")
		return

	if player.is_holding:
		print("GAME OK")
		var game = preload("res://Assets/Scenes/clicker_minigame.tscn").instantiate()

		get_tree().root.add_child(game)

		player.current_minigame = game
		game.start(player)

	elif player.is_holding:
		print("GAME OK")
		var game = preload("res://Assets/Scenes/counter_minigame.tscn").instantiate()

		get_tree().root.add_child(game)

		player.current_minigame = game
		game.start(player)
