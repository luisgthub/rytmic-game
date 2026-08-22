extends Node

var score = 0
var value = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_score(value):
	score +=value
	
func _process(delta: float) -> void:
	pass
