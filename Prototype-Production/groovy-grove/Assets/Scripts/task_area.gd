extends Node2D

enum State { DAMAGED, IN_PROGRESS, HEALED }

signal task_completed(task_area)

const INTERACTABLE_SCENE = preload("res://Assets/Scenes/interactable.tscn")

@export var state: int = State.DAMAGED
@export var task_type: String = "trash"
@export var required_item: String = ""
@export var secondary_required_item: String = ""
@export var progress_required: int = 3
@export var task_name: String = "Task"

var progress: int = 0

func _ready() -> void:
	_ensure_interactable_area()
	update_visuals()
	add_to_group("TaskAreas")

func _ensure_interactable_area() -> void:
	if has_node("InteractableArea"):
		$InteractableArea.interact = Callable(self, "_on_interact")
		return

	var interactable = INTERACTABLE_SCENE.instantiate()
	interactable.name = "InteractableArea"
	add_child(interactable)
	interactable.interact = Callable(self, "_on_interact")

func _on_interact(player) -> void:
	if state == State.DAMAGED and can_start_task(player):
		start_task(player)
		return
	if state == State.IN_PROGRESS:
		add_progress()

func can_start_task(player) -> bool:
	if state != State.DAMAGED:
		return false
	if required_item != "" and not _player_has_tool(player, required_item):
		return false
	if secondary_required_item != "" and not _player_has_tool(player, secondary_required_item):
		return false
	return true

func _player_has_tool(player, item_name: String) -> bool:
	if item_name == "":
		return true
	if player.is_holding and player.held_item_name == item_name:
		return true
	return _other_player_has_tool(player, item_name)

func _other_player_has_tool(player, item_name: String) -> bool:
	for other in get_tree().get_nodes_in_group("Players"):
		if other == player:
			continue
		if other.is_holding and other.held_item_name == item_name:
			if other.global_position.distance_to(player.global_position) < 120:
				return true
	return false

func start_task(player) -> void:
	if not can_start_task(player):
		return
	state = State.IN_PROGRESS
	progress = 0
	update_visuals()
	show_task_status("%s started" % task_name)

func add_progress(amount: int = 1) -> void:
	if state != State.IN_PROGRESS:
		return
	progress += amount
	show_task_status("%s progress %d/%d" % [task_name, progress, progress_required])
	if progress >= progress_required:
		finish_task()

func finish_task() -> void:
	state = State.HEALED
	update_visuals()
	show_task_status("%s complete" % task_name)
	emit_signal("task_completed", self)
	InteractionManager.tasksDone += 1

func set_state(new_state: int) -> void:
	state = new_state
	if state == State.IN_PROGRESS:
		progress = 0
	update_visuals()

func update_visuals() -> void:
	if not has_node("Sprite2D"):
		return
	match state:
		State.DAMAGED:
			$Sprite2D.modulate = Color(1, 0.6, 0.6)
		State.IN_PROGRESS:
			$Sprite2D.modulate = Color(1, 1, 0.5)
		State.HEALED:
			$Sprite2D.modulate = Color(0.6, 1, 0.6)

func show_task_status(text: String) -> void:
	if has_node("Label"):
		$Label.text = text
