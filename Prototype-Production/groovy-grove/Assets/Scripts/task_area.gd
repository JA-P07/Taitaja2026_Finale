extends Node2D
enum State { DAMAGED, IN_PROGRESS, HEALED }

@export var state: int = State.DAMAGED
@export var task_type: String = "trash"

func _ready():
	update_visuals()
	add_to_group("TaskAreas")

func set_state(new_state: int) -> void:
	state = new_state
	update_visuals()

func update_visuals() -> void:
	match state:
		State.DAMAGED:
			$Sprite2D.modulate = Color(1, 0.6, 0.6)
		State.IN_PROGRESS:
			$Sprite2D.modulate = Color(1, 1, 0.5)
		State.HEALED:
			$Sprite2D.modulate = Color(0.6, 1, 0.6)
