extends Node

signal completed(player)

@onready var timer = $Timer
@onready var status = $Status

var player
var counter = 0
var maxcounter = 10
var success = false

func _ready() -> void:
	status.text = "KEEP PRESSING E OR (A)"
	timer.start()

func start(p):
	player = p
	status.text = "KEEP PRESSING E OR (A)"
	counter = 0
	success = false
	timer.start()

func on_interact_pressed():
	if success:
		return
	counter += 1
	print("P", player.playerID, ":", counter)
	check_success()

func check_success():
	if counter >= maxcounter:
		success = true
		status.text = "YOU WIN"
		emit_signal("completed", player)

