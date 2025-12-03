extends CharacterBody2D

const GRAVIDADE = 1000

# Variáveis
var esta_caindo = false
var esta_tremendo = false
var posicao_x_inicial = 0.0

@onready var sprite = $Sprite2D # Certifique-se que o nome do nó é Sprite2D

func _ready():
	posicao_x_inicial = position.x

func _physics_process(delta):
	if esta_caindo:
		velocity.y += GRAVIDADE * delta
		move_and_slide()
		
		# Se cair muito longe, deleta para limpar memória
		if position.y > 1000: 
			queue_free()
			
	elif esta_tremendo:
		# Faz o sprite vibrar para os lados
		sprite.position.x = randf_range(-2, 2)

# --- SINAL ---
# Lembre de conectar o sinal "body_entered" da Area2D neste script!
func _on_area_2d_body_entered(body):
	# Verifica se é o Player e se a plataforma ainda está inteira
	if body.name == "Player" and not esta_caindo and not esta_tremendo:
		cair_plataforma()

func cair_plataforma():
	# 1. Começa a tremer
	esta_tremendo = true
	
	# Espera 0.5 segundos tremendo
	await get_tree().create_timer(0.5).timeout
	
	# 2. Para de tremer e começa a cair
	esta_tremendo = false
	sprite.position.x = 0
	esta_caindo = true
	
	# --- NOVO: EFEITO DE DESAPARECER (FADE OUT) ---
	
	# Cria um animador (Tween)
	var tween = create_tween()
	
	# Configura a animação:
	# "Mude a propriedade 'modulate:a' (transparência) para 0, num tempo de 1.5 segundos"
	tween.tween_property(self, "modulate:a", 0.0, 1.5)
	
	# Quando a animação acabar, chama queue_free() automaticamente para limpar da memória
	tween.tween_callback(queue_free)
	
