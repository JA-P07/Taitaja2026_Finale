extends Node
@onready var players = get_tree().get_first_node_in_group("Players")
@onready var label = $Label;
var tasksDone: float = 0
var secTasksDone: int = 0

const base_text = "=E OR A= TO "

var active_areas = {};
var can_interact = true;

func register_area(area: InteractableArea, body):
	if !active_areas.has(body):
		active_areas[body] = []
	active_areas[body].push_back(area)

func unregister_area(area: InteractableArea, body):
	if active_areas.has(body):
		active_areas[body].erase(area)
		if active_areas[body].is_empty():
			active_areas.erase(body)

func _process(delta):
	label.hide()
	for player in active_areas.keys():
		var areas = active_areas[player]
		if areas.size() > 0 and can_interact:
			areas.sort_custom(func(a, b):
				return player.global_position.distance_to(a.global_position) < player.global_position.distance_to(b.global_position)
			)
			var closest = areas[0]
			label.text = base_text + closest.action_name
			label.global_position = closest.global_position
			label.global_position.y -= 36
			label.global_position.x -= label.size.x / 2
			label.show()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = players.global_position.distance_to(area1.global_position)
	var area2_to_player = players.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	for player in active_areas.keys():
		var interact_action = "interact%s" % player.playerID
		if event.is_action_pressed(interact_action) and can_interact:
			var areas = active_areas[player]
			if areas.size() > 0:
				can_interact = false
				var closest_area = areas[0]
				await closest_area.interact.call(player)
				can_interact = true
