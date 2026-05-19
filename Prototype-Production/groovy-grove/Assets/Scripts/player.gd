extends CharacterBody2D


@export var _speed: float = 300.0


func _physics_process(delta: float) -> void:
	_check_movement()
	
func _check_movement() -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * _speed
	move_and_slide()
