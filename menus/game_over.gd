extends CanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#ESTATISTICA
	$VBoxContainer/perf.text = "Perfeitos " + str(Manager.perfeito)
	$VBoxContainer/otimo.text = "Otimos " + str(Manager.otimo)
	$VBoxContainer/bom.text = "Bons " + str(Manager.bom)
	$VBoxContainer/erro.text = "Erros " + str(Manager.erro)
	#PONTUACAO
	$pontuacao/score.text = "Pontuação " + str(Manager.score)
	$pontuacao/streak.text = "Combo " + str(Manager.streak)+"x"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#teste
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		$confirm.play()
		_on_restart_pressed() 

func _on_restart_pressed() -> void:
	Manager.score = 0
	Manager.streak = 0
	Manager.bom = 0
	Manager.perfeito = 0
	Manager.otimo = 0
	Manager.erro = 0
	
	
	Transition.change_scene("res://menus//music_menu.tscn")
	self.queue_free()
