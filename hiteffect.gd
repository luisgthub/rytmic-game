extends Node2D

@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$hit.pitch_scale = randf_range(0.8,1.0)
	$hit.play()
	anim.play("normal")
	$hit.volume_db = -20.0
	anim.animation_finished.connect(_on_animation_finished)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_finished(anim_name: StringName) -> void:
	queue_free()
