extends CharacterBody2D

@export var _speed: float = 150.0
@export var playerID = 0
@onready var playerAnim = $PlayerAnim
@onready var playerSprite = $PlayerSprite

var current_minigame = null

var held_item_name = ""
var held_item_instance: Node2D = null
var is_holding = false

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
	
	if Input.is_action_just_pressed("interact%s" % playerID):
		try_interact()
		if current_minigame and current_minigame.has_method("on_interact_pressed"):
			current_minigame.on_interact_pressed()
	if Input.is_action_just_pressed("drop%s" % playerID):
		drop_item()
	if Input.is_action_just_pressed("MiniGame_left%s" % playerID):
		if current_minigame and current_minigame.has_method("on_left_pressed"):
			current_minigame.on_left_pressed()
	if Input.is_action_just_pressed("MiniGame_right%s" % playerID):
		if current_minigame and current_minigame.has_method("on_right_pressed"):
			current_minigame.on_right_pressed()
	
func moveAnimation():
	if velocity.y > 0 && Input.is_action_pressed("move_down%s" % playerID):
		if playerAnim.current_animation != "moveDown%s" % playerID:
			playerAnim.play("moveDown%s" % playerID)
	elif velocity.y < 0  && Input.is_action_pressed("move_up%s" % playerID):
		if playerAnim.current_animation != "moveUp%s" % playerID:
			playerAnim.play("moveUp%s" % playerID)
	else:
		playerAnim.stop()

func pickup_item(item_name, item_instance):

	is_holding = true
	held_item_name = item_name
	held_item_instance = item_instance
	item_instance.reparent(self)
	item_instance.position = Vector2.ZERO
	item_instance.get_node("InteractableArea").monitoring = false
	item_instance.get_node("InteractableArea").collision_layer = 0
	item_instance.get_node("InteractableArea").collision_mask = 0
	print("Player picked up" + held_item_name)

func drop_item():

	if !is_holding:
		return

	if held_item_instance.has_node("InteractableArea"):
		var interact_area = held_item_instance.get_node("InteractableArea")
		interact_area.monitoring = true
		interact_area.collision_layer = 0
		interact_area.collision_mask = 2

	held_item_instance.reparent(get_parent())
	held_item_instance.global_position = global_position + Vector2(0, 16)
	held_item_instance = null
	held_item_name = ""
	is_holding = false

func try_interact():
	var areas = $InteractionDetector.get_overlapping_areas()
	if areas.size() > 0:
		var interactable = areas[0]
		if interactable.interact:
			interactable.interact.call(self)
