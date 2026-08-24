extends Node2D

@export var bloco_scene: PackedScene 

# Configurações do Fundo
var total_blocos: int = 6
var largura_tela: float = 480.0
var altura_tela: float = 360.0

var blocos: Array = []

func _ready() -> void:
	# Gera 6 blocos 
	for i in range(total_blocos):
		gerar_bloco_inicial()

func _process(delta: float) -> void:
	for dados in blocos:
		var bloco = dados["node"]
		var vel_x = dados["speed"]
		var vel_rot = dados["rot_speed"]
		
		bloco.position.x += vel_x * delta
		bloco.rotation += vel_rot * delta
		
		# Se passou do lado direito da tela, dá a volta com fade-in suave
		if bloco.position.x > largura_tela + 20:
			respawnar_bloco(bloco, dados)

func gerar_bloco_inicial() -> void:
	if bloco_scene == null:
		print("ERRO: Esqueceu de arrastar a cena do bloco para o export no Inspetor!")
		return
		
	var novo_bloco = bloco_scene.instantiate()
	
	novo_bloco.position = Vector2(
		randf_range(0.0, largura_tela),
		randf_range(0.0, altura_tela)
	)
	
	# Mantém a sua escala e opacidade originais
	var escala = randf_range(1.5, 2.2)
	novo_bloco.scale = Vector2.ZERO # Começa zerado para o efeito Pop de spawn
	novo_bloco.modulate.a = 0.0 
	
	add_child(novo_bloco)

	var dados_bloco = {
		"node": novo_bloco,
		"speed": randf_range(30.0, 70.0),      
		"rot_speed": randf_range(0.5, 2.0),
		"escala_base": escala
	}
	blocos.append(dados_bloco)
	
	# Efeito de Tween (Pop elástico de entrada + fade para o valor original)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(novo_bloco, "scale", Vector2(escala, escala), 0.6).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(novo_bloco, "modulate:a", randf_range(0.2, 0.5), 0.4)
	
	# Inicia a pulsação contínua (respiração)
	criar_animacao_pulso(novo_bloco, escala)

func respawnar_bloco(bloco: Node2D, dados: Dictionary) -> void:
	bloco.position.x = randf_range(-40.0, -10.0)
	bloco.position.y = randf_range(10.0, altura_tela - 10.0)
	dados["speed"] = randf_range(30.0, 70.0)
	dados["rot_speed"] = randf_range(0.5, 2.0)
	
	# Fade-in suave ao dar a volta na tela
	bloco.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(bloco, "modulate:a", randf_range(0.2, 0.5), 0.5)

func criar_animacao_pulso(bloco: Node2D, escala_base: float) -> void:
	if not is_instance_valid(bloco): return
	
	var tween = create_tween()
	var variacao = escala_base * 0.15
	
	tween.tween_property(bloco, "scale", Vector2(escala_base + variacao, escala_base + variacao), randf_range(1.0, 1.8)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(bloco, "scale", Vector2(escala_base, escala_base), randf_range(1.0, 1.8)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func(): criar_animacao_pulso(bloco, escala_base))
