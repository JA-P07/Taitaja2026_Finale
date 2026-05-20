extends CharacterBody2D

@export var _speed: float = 150.0
@export var playerID = 0
@onready var playerAnim = $PlayerAnim
@onready var playerSprite = $PlayerSprite

var rope_force = Vector2.ZERO

func _ready() -> void:
	if playerID == 0:
		playerSprite.frame = 8
	else:
		playerSprite.frame = 0
		

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
	
	moveAnimation()
	
	move_and_slide()

	rope_force = Vector2.ZERO
	
	
	
func moveAnimation():
	if velocity.y > 0 && Input.is_action_pressed("move_down%s" % playerID):
		if playerAnim.current_animation != "moveDown%s" % playerID:
			playerAnim.play("moveDown%s" % playerID)
	elif velocity.y < 0  && Input.is_action_pressed("move_up%s" % playerID):
		if playerAnim.current_animation != "moveUp%s" % playerID:
			playerAnim.play("moveUp%s" % playerID)
	else:
		playerAnim.stop()
