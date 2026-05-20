extends StaticBody2D



func _process(delta: float) -> void:
	if InteractionManager.tasksDone < 9.0:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
