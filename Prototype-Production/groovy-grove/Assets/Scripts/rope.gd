extends Node2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var line_2d: Line2D
@export var max_length: float = 150.0
@export var spring_strength: float = 5.0
@onready var _raycast = $RopeRay
@onready var _ropeArea = $RopeCol
var ropeHealth: int = 3


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
		
		_raycast.global_position = player1.global_position
		
		_raycast.target_position = _raycast.to_local(player2.global_position)
		$RopeCol/CollisionShape2D.shape.a = Vector2(player1.global_position)
		$RopeCol/CollisionShape2D.shape.b = Vector2(player2.global_position)
		$CanvasLayer/Control/Label.text = "ROPE HEALTH = %s" % ropeHealth
		$CanvasLayer/Control/Label2.text = "TASKS DONE = %s" % InteractionManager.tasksDone
		$CanvasLayer/Control/Label3.text = "INVASIVE PLANTS DESTROYED = %s" % InteractionManager.secTasksDone

func _on_rope_col_body_entered(body: Node2D) -> void:
	print("something thorny hit the rope?")
	ropeHealth -= 1
	if ropeHealth == 0:
		print("LOSE")
		
