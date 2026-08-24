extends CanvasLayer

var rect: ColorRect

func _ready() -> void:
	# 1. Tenta achar o ColorRect existente ou cria um novo na hora por segurança
	if has_node("ColorRect"):
		rect = $ColorRect
	else:
		rect = ColorRect.new()
		rect.name = "ColorRect"
		add_child(rect)
	
	# 2. Configura para cobrir a tela toda (480x360) e iniciar invisível
	rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	rect.color = Color(0, 0, 0, 0) # Preto com transparência 0
	visible = false

func change_scene(target_scene_path: String) -> void:
	# Garante que o rect existe antes de rodar
	if rect == null:
		_ready()
		
	visible = true
	
	# 1. Escurece a tela (Fade Out)
	var tween_out = create_tween()
	tween_out.tween_property(rect, "color:a", 1.0, 0.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween_out.finished
	
	# 2. Troca a cena por baixo do pano
	get_tree().change_scene_to_file(target_scene_path)
	
	# 3. Revela a nova tela (Fade In)
	var tween_in = create_tween()
	tween_in.tween_property(rect, "color:a", 0.0, 0.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween_in.finished
	
	visible = false
