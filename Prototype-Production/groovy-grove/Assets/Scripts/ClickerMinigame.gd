extends Node

@onready var timer = $Timer;
@onready var status = $Status;
@export var counter = 0;
@export var maxcounter = 10;
var success = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print ("start")
	status.text = "KEEP PRESSING E OR A"
	timer.start();
func successCheck():
	if counter == maxcounter:
		success = true;
		print("success");
		status.text = "YOU WIN"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	successCheck();
	if timer.time_left == 0.0 and success == false:
		print("fail");
		status.text = "FAIL"
		pass
	elif Input.is_action_just_pressed("interact0"):
		counter = counter + 1;
		print(counter);
	elif success == true:
		pass
		
