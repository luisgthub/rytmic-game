extends Node2D
@onready var seta: Node = $seta
@onready var btn1: TextureButton = $HBoxContainer/song1
@onready var btn2: TextureButton = $HBoxContainer/song2
@onready var btn3: TextureButton = $HBoxContainer/song3

@onready var title = $Label
func _ready() -> void:
	btn1.focus_mode = Control.FOCUS_ALL
	btn2.focus_mode = Control.FOCUS_ALL
	btn3.focus_mode = Control.FOCUS_ALL

	btn1.focus_neighbor_right = btn2.get_path()
	btn1.focus_neighbor_left = btn3.get_path() 

	btn2.focus_neighbor_right = btn3.get_path()
	btn2.focus_neighbor_left = btn1.get_path()

	btn3.focus_neighbor_right = btn1.get_path() 
	btn3.focus_neighbor_left = btn2.get_path()
	# Conecta o evento 
	btn1.focus_entered.connect(func(): mover_seta_para(btn1))
	btn2.focus_entered.connect(func(): mover_seta_para(btn2))
	btn3.focus_entered.connect(func(): mover_seta_para(btn3))
	
	# Foca o primeiro botão 
	btn1.grab_focus()

func mover_seta_para(botao: TextureButton) -> void:
	var pos_x = botao.global_position.x + (botao.size.x / 2.0)
	var pos_y = botao.global_position.y - 30.0
	
	seta.global_position = Vector2(pos_x, pos_y)
	

	var tween_seta = create_tween().set_loops()
	

	tween_seta.tween_property(seta, "global_position:y", pos_y - 6.0, 0.4)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
		

	tween_seta.tween_property(seta, "global_position:y", pos_y, 0.4)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
		
	$select.play()
	$select.pitch_scale = randf_range(0.4,0.7)
#PRESSED

func _on_botao_1_pressed() -> void:
	Transition.change_scene("res://fases/trilha.tscn")

func _on_botao_2_pressed() -> void:
	Transition.change_scene("res://fases/trilha2.tscn")

func _on_botao_3_pressed() -> void:
	Transition.change_scene("res://fases/trilha3.tscn")
func _process(delta: float) -> void:
	# Seleciona a música
	if Input.is_action_just_pressed("confirm"):
		var botao_focado = get_viewport().gui_get_focus_owner()
		if botao_focado is TextureButton:
			botao_focado.emit_signal("pressed")
	
	
	
	
	if Input.is_action_just_pressed("quit"):
		_on_restart_pressed() 






func _on_restart_pressed() -> void:
	Transition.change_scene("res://menus//start.tscn")
