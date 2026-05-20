extends Node

@onready var interaction_area: InteractableArea = $InteractableArea

var players_in_area: Array = []
var spade_step_done: bool = false

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.monitoring = true
	interaction_area.connect("body_entered", Callable(self, "_on_body_entered"))
	interaction_area.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("Players") and not players_in_area.has(body):
		players_in_area.append(body)

func _on_body_exited(body):
	if body.is_in_group("Players"):
		players_in_area.erase(body)

func _get_players_in_area() -> Array:
	var players: Array = []
	for body in interaction_area.get_overlapping_bodies():
		if body.is_in_group("Players"):
			players.append(body)
	return players

func _on_interact(player):
	var players_present = _get_players_in_area()
	if not spade_step_done:
		if players_present.size() < 2:
			print("Both players need to be here", "present=", players_present.size())
			return
		if player.is_holding and player.held_item_instance.is_in_group("spade"):
			_start_spade_step(player)
		else:
			print("You need to use the spade first")
		return

	# After the spade step, only the player with the seedbag needs to finish planting.
	if player.is_holding and player.held_item_instance.is_in_group("seedbag"):
		_start_seed_step(player)
	else:
		print("Spade is done. Now use the seedbag")

func _start_spade_step(player):
	var game = preload("res://Assets/Scenes/clicker_minigame.tscn").instantiate()
	get_tree().root.add_child(game)
	player.current_minigame = game
	game.connect("completed", Callable(self, "_on_minigame_completed").bind("spade"))
	game.start(player)

	elif player.is_holding and player.held_item_instance.is_in_group("seedbag"):

		var game = preload("res://Assets/Scenes/counter_minigame.tscn").instantiate()

		get_tree().root.add_child(game)

		player.current_minigame = game
		game.start(player)
