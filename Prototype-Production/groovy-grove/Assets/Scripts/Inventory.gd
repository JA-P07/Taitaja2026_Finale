extends Node
@onready var player = $Player;
@onready var label = $Label;
@export var ID = player.playerID;
@export var currentItem = 0;

var isHolding = false;

@export var ItemName = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isHolding == false:
		label.text = "";

func Pickup(ItemName):
	isHolding = true;
	label.text = "HOLDING" + ItemName;
