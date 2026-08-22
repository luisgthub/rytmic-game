extends TextureButton
class_name ButtonConfig
@export var keyboard_pressed:String = ""
@export var text_pressed:Texture2D
@export var anim:PackedScene 
@export var normal_text:Texture2D
@onready var part = $CPUParticles2D
signal send_key_pressed(key:String)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_normal = normal_text
	if texture_normal:
		texture_normal = normal_text
	if text_pressed:
		texture_pressed = text_pressed
	part.emitting = false
	part.one_shot = true
func hit_confirm():
	var inst = anim.instantiate()
	inst.position = part.position
	add_child(inst)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if  keyboard_pressed != "" and Input.is_action_just_pressed(keyboard_pressed):
		activate_button()
		hit_confirm()
	if Input.is_action_just_released(keyboard_pressed):
		texture_normal = normal_text

func activate_button():

	texture_normal = text_pressed
	part.emitting = true
	print("teclado ",keyboard_pressed)
	send_key_pressed.emit(keyboard_pressed)
	
