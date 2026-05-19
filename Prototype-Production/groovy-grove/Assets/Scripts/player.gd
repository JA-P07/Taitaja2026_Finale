extends CharacterBody2D

@export var _speed: float = 150.0
@export var playerID = 0

var rope_force = Vector2.ZERO

func apply_rope_force(force: Vector2):
	rope_force = force

func _physics_process(delta: float) -> void:
	var move_left = "move_left%s" % playerID
	var move_right = "move_right%s" % playerID
	var move_up = "move_up%s" % playerID
	var move_down = "move_down%s" % playerID
	
	
	
	
	var direction := Input.get_vector(move_left, move_right, move_up, move_down)
	velocity = direction * _speed
	
	velocity += rope_force
	
	move_and_slide()

	rope_force = Vector2.ZERO 
