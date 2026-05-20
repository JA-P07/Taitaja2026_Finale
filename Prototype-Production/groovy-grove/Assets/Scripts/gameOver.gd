extends Node
@onready var start = $Buttons/Play
@onready var quit = $Buttons/Quit

func _process(delta: float) -> void:
	if start.is_pressed() == true:
		playGame();
	elif quit.is_pressed() == true:
		quitGame();
func quitGame():
		get_tree().quit();

func playGame():
	get_tree().change_scene_to_file("res://Assets/Scenes/map.tscn")
