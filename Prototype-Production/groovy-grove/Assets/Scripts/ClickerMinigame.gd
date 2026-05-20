extends Node

@onready var timer = $Timer
@onready var status = $Status

var player
var counter = 0
var maxcounter = 10
var success = false

func start(p):
	player = p
	status.text = "KEEP PRESSING E OR A"
	timer.start()

func on_interact_pressed():

	if success:
		return

	counter += 1
	print("P", player.playerID, ":", counter)
	success_check()

func success_check():
	if counter >= maxcounter:
		success = true
		status.text = "YOU WIN"
