extends Node2D

@onready var capoeirista = $Sprite2D
#da pra pegar isso aqui por signal ou função has_method
func _ready() -> void:
	capoeirista.hframes = 9
	capoeirista.frame = 0
	$smoke.emitting = false
	$smoke.one_shot = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_rating_anim(rating:String):
	$smoke.emitting = true
	match rating:
		"bom":
			# Sorteia um frame entre 1 e 2 para acertos normais/bons
			capoeirista.frame = randi_range(1, 2)
			
		"otimo":
			# Sorteia um frame entre 3 e 5 para acertos ótimos
			capoeirista.frame = randi_range(3, 5)
			
		"perfeito":
			# Sorteia um frame entre 6 e 8 para acertos perfeitos (movimentos mais complexos/fortes)
			capoeirista.frame = randi_range(6, 8)
