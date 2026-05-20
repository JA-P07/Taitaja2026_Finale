extends Node

signal completed(player)

@onready var status = $Status

var player
var counter = 0
var maxcounter = 10
var left = true
var success = false

func start(p):
	player = p
	status.text = "Q OR RB"
	counter = 0
	left = true
	success = false

func on_left_pressed():
	if success or !left:
		return
	counter += 1
	left = false
	check_success()

func on_right_pressed():
	if success or left:
		return
	counter += 1
	left = true
	check_success()

func check_success():
	if counter >= maxcounter:
		success = true
		status.text = "YOU WIN"
		emit_signal("completed", player)
