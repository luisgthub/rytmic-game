extends Control

@onready var label = $Label

var choose_rating: String:
	set(value):
		choose_rating = value
		exibir_texto() 

func _ready() -> void:
	exibir_texto()
	

	var tween = create_tween().set_parallel(true)
	tween.tween_property(label, "scale", Vector2(1.5, 1.5), 0.1)
	tween.chain().tween_property(label, "scale", Vector2(1.0, 1.0), 0.1)
	

	tween.tween_property(label, "position:y", label.position.y - 32.0, 0.5)
	tween.tween_property(label, "modulate:a", 0.0, 0.5)
	

	get_tree().create_timer(0.5).timeout.connect(queue_free)

func exibir_texto() -> void:
	if not is_node_ready() or label == null:
		return
		
	match choose_rating:
		"bom":
			label.modulate = Color.MEDIUM_SEA_GREEN
			label.text = "BOM !"
		"otimo":
			label.modulate = Color.DEEP_SKY_BLUE
			label.text = "OTIMO !"
		"perfeito":
			label.modulate = Color.YELLOW
			label.text = "PERFEITO !"
		"erro":
			label.modulate = Color.RED
			label.text = "ERROU !"
