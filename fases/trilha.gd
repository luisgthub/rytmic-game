extends Node2D

@onready var button_left = $CenterContainer/VBoxContainer/left
@onready var button_up = $CenterContainer/VBoxContainer/up
@onready var button_right = $CenterContainer/VBoxContainer/right
@onready var vbox = $CenterContainer/VBoxContainer
@onready var capo = $capoeirista
#AUDIO
@onready var score_label = $score_label
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer_spawn: Timer = $TimerSpawn
var button_box_start = Vector2(30, 50)

@export var block_left: PackedScene
@export var block_up: PackedScene
@export var block_right: PackedScene
var count_perfects:int= 0
var speed = 100 # Aumentado para fluir mais rápido
var block_left_start = Vector2(360, 50)
var block_up_start = Vector2(360, 90)
var block_right_start = Vector2(360, 130)

# Lista para guardar todas as notas ativas na tela ao mesmo tempo
var active_notes: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_left.send_key_pressed.connect(_on_send_key_pressed)
	button_up.send_key_pressed.connect(_on_send_key_pressed)
	button_right.send_key_pressed.connect(_on_send_key_pressed)
	vbox.position = button_box_start
	
	# AUDIO
	timer_spawn.timeout.connect(_on_timer_spawn_timeout)
	audio_player.play()

func _physics_process(delta: float) -> void:
	#SCORE
	score_label.text = "%08d" % Manager.score
	
	# Move todas as notas ativas de uma vez si
	for i in range(active_notes.size() - 1, -1, -1):
		var note = active_notes[i]
		
		if note == null or not is_instance_valid(note):
			active_notes.remove_at(i)
			continue
			
		# Move para a esquerda
		note.position.x += -speed * delta
		
		# Pega a referência do botão correspondente para saber quando passou reto
		var ref_button = button_left
		if note.is_in_group("up_notes"): ref_button = button_up
		elif note.is_in_group("right_notes"): ref_button = button_right
		
		# Se passou do botão, dá MISS e remove
		if note.global_position.x < ref_button.global_position.x - 10:
			print("MISS! Passou reto.")
			active_notes.remove_at(i)
			note.queue_free()

func _on_timer_spawn_timeout() -> void:
	var pista_sorteada = randi() % 3
	var novo_bloco = null
	
	match pista_sorteada:
		0:
			novo_bloco = block_left.instantiate()
			novo_bloco.position = block_left_start
			novo_bloco.add_to_group("left_notes")
		1:
			novo_bloco = block_up.instantiate()
			novo_bloco.position = block_up_start
			novo_bloco.add_to_group("up_notes")
		2:
			novo_bloco = block_right.instantiate()
			novo_bloco.position = block_right_start
			novo_bloco.add_to_group("right_notes")
	
	if novo_bloco:
		$Sprite2D.add_child(novo_bloco)
		active_notes.append(novo_bloco) # Adiciona na lista geral de notas

func tap_note(button: TextureButton, track_group: String):
	# Procura a nota mais próxima daquele botão que pertence a essa pista
	var closest_note = null
	var min_dist = 999999
	for note in active_notes:
		if note.is_in_group(track_group) and is_instance_valid(note):
			var dist = abs(button.global_position.x - note.global_position.x)
			if dist < min_dist:
				min_dist = dist
				closest_note = note
				
	if closest_note == null:
		print("Não há nota nesta pista!")
		return
		
	print("distancia da nota pro botao: ", min_dist)
	
	var rating = ""
	if min_dist <= 20:
		rating = "perfeito"
		count_perfects+=1
		if count_perfects>=5:
			$perfect.play()
			$perfect.pitch_scale = randf_range(0.8,1.0)
			count_perfects = 0
		capo.play_rating_anim(rating)
		Manager.add_score(50)
	elif min_dist <= 30:
		count_perfects = 0
		rating = "otimo"
		capo.play_rating_anim(rating)
		Manager.add_score(40)
	elif min_dist <= 40:
		count_perfects = 0
		rating = "bom"
		capo.play_rating_anim(rating)
		Manager.add_score(20)
	else:
		print("erro de timing")
		return

	if closest_note.has_method("destroy_note"):
		closest_note.destroy_note(rating)
		
	# Remove da lista e apaga
	active_notes.erase(closest_note)
	closest_note.queue_free()

func _on_send_key_pressed(key: String) -> void:
	match key:
		"left":
			tap_note(button_left, "left_notes")
		"up":
			tap_note(button_up, "up_notes")
		"right":
			tap_note(button_right, "right_notes")
