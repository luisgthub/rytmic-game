extends Control

@onready var bom = preload("res://assets/feedback/good.png")
@onready var otimo = preload("res://assets/feedback/great.png")
@onready var perfeito = preload("res://assets/feedback/perfect.png")
@onready var normal_texture = $change_texture
var choose_texture:String
var rating_receive:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match choose_texture:
		"bom":
			$change_texture.texture = bom
		"otimo":
			$change_texture.texture = otimo
		"perfeito":
			$change_texture.texture = perfeito
	get_tree().create_timer(1.0).timeout.connect(queue_free)
	var tween = create_tween().set_parallel(true)
	tween.tween_property($change_texture,"scale",Vector2(1.5,1.5),0.2)
	tween.tween_property($change_texture,"scale",Vector2(1.0,1.0),0.1)
	tween.tween_property($change_texture,"position:y",-32.0,0.5)
	tween.tween_property($change_texture,"modulate:a",0.0,0.5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
