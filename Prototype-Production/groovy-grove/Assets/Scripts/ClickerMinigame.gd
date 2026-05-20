extends Node

@onready var timer = $Timer
@onready var status = $Status

var player
var counter = 0
var maxcounter = 10
var success = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print ("start")
	status.text = "KEEP PRESSING E OR (A)"
	timer.start();
func successCheck():
	if counter == maxcounter:
		success = true;
		print("success");
		status.text = "YOU WIN"

	if success:
		return

	counter += 1
	print("P", player.playerID, ":", counter)
	success_check()

func success_check():
	if counter >= maxcounter:
		success = true
		status.text = "YOU WIN"
