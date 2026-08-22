extends StaticBody2D
@export var notify:PackedScene
@onready var parti = $CPUParticles2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func create_notify(rating):
	var inst = notify.instantiate()
	inst.choose_texture = rating
	inst.global_position = Vector2(240,180)
	get_tree().current_scene.add_child(inst)
	
func destroy_note(rating):
	create_notify(rating)
	queue_free()
			
	
