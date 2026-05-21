extends Node2D




func _on_win_area_body_entered(body: Node2D) -> void:

	get_tree().change_scene_to_file("res://Assets/Scenes/win_screen.tscn")
