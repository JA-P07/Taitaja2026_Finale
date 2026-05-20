extends Node2D

enum State { DAMAGED, IN_PROGRESS, HEALED }

signal task_completed(task_area)

@export var state: int = State.DAMAGED
@export var task_type: String = "trash"
@export var required_item: String = ""
@export var progress_required: int = 3
@export var task_name: String = "Task"

var progress: int = 0

func _ready() -> void:
	update_visuals()
	add_to_group("TaskAreas")

func can_start_task(player) -> bool:
	if state != State.DAMAGED:
		return false
	if required_item == "":
		return true
	return player.is_holding and player.held_item_name == required_item

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
