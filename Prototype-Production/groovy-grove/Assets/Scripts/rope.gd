extends Node2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var line_2d: Line2D
@export var max_length: float = 150.0
@export var spring_strength: float = 5.0

func _physics_process(delta):
	if not player1 or not player2:
		return

	var diff = player2.global_position - player1.global_position
	var distance = diff.length()
	
	if distance > max_length:
		var overlap = distance - max_length
		var pull_force = diff.normalized() * overlap * spring_strength
		
		# Inject the pulling force directly into the players' velocities
		# This ensures they respect wall collisions!
		if player1.has_method("apply_rope_force"):
			player1.apply_rope_force(pull_force)
		if player2.has_method("apply_rope_force"):
			player2.apply_rope_force(-pull_force)

func _process(_delta):
	if line_2d and player1 and player2:
		line_2d.points = [line_2d.to_local(player1.global_position), line_2d.to_local(player2.global_position)]
