extends Control

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property($VBoxContainer/start,"modulate:a",0.0,0.4)
	tween.tween_property($VBoxContainer/start,"modulate:a",1.0,0.5)
	
	tween.tween_property($Sprite2D,"modulate:a",0.0,0.4)
	tween.tween_property($Sprite2D,"modulate:a",1.0,0.3)
	tween.tween_property($Sprite2D,"scale",Vector2(1.2,1.2),0.2)
	tween.tween_property($Sprite2D,"scale",Vector2(1.0,1.0),0.3)
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		$confirm.play()
		iniciar_jogo()

func _on_start_pressed() -> void:
	# Inicia clicando no botão da tela
	iniciar_jogo()

func iniciar_jogo() -> void:
	Transition.change_scene("res://menus/music_menu.tscn")
