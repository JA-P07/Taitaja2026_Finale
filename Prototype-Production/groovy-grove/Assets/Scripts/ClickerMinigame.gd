extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("start");
	await get_tree().create_timer(1.0).timeout;

func _on_timer_timeout():
	print("fail")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
