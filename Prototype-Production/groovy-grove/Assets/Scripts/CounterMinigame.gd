extends Node
@export var counter = 0;
@export var maxcounter = 10;
@onready var status = $StatusText;
var left = true;
var success = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	status.text = "PRESS LEFT"
	
func successCheck():
	if counter >= maxcounter:
		success = true
		print(success)
		status.text = "YOU WIN"
	else:
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	
	if left == true and success == false:
		successCheck()
		if Input.is_action_just_pressed("MiniGame_left"):
			counter = counter + 1;
			print(counter)
			left = false;
			status.text = "PRESS RIGHT"
	elif  left == false and success == false:
		if Input.is_action_just_pressed("MiniGame_right"):
			counter = counter + 1;
			print(counter)
			left = true;
			status.text = "PRESS LEFT"
	else:
		pass
