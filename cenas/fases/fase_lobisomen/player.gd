extends CharacterBody2D

const SPEED := 115
const JUMP_FORCE := -360
const GRAVITY := 900

const FRAME_DO_DANO := 4 

@onready var anim = $AnimatedSprite2D
@onready var area_ataque = $AreaAtaque
@onready var attack_sound = $AudioStreamPlayer2D

var tempo_parado: float = 0.0
var esta_atacando: bool = false
var atacou_neste_ciclo: bool = false # Garante que só dá dano 1 vez por ataque

func _ready():
	if not anim.animation_finished.is_connected(_on_animation_finished):
		anim.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	# 1. Aplica Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# 2. Input de Ataque (Só ataca se estiver no chão e não estiver atacando)
	if Input.is_action_just_pressed("attack") and is_on_floor() and not esta_atacando:
		iniciar_ataque()
	
	# 3. Lógica de Estados
	if esta_atacando:
		processar_ataque()
	else:
		processar_movimento(delta)

	# 4. Move o Player
	move_and_slide()

# --- FUNÇÕES DE LÓGICA ---

func processar_ataque():
	# Reduz a velocidade suavemente enquanto ataca (efeito de inércia)
	velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Lógica do Frame Perfeito:
	# Verifica se estamos na animação de ataque, no frame certo, e se ainda não batemos
	if anim.animation == "attack" and anim.frame == FRAME_DO_DANO and not atacou_neste_ciclo:
		aplicar_dano_nos_inimigos()
		atacou_neste_ciclo = true # Trava para não bater de novo no mesmo ataque

func processar_movimento(delta: float):
	# Captura direção
	var dir := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = dir * SPEED

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	# --- Gerenciamento de Animações e Direção ---
	
	# Inverter Sprite e Hitbox
	if dir > 0:
		anim.flip_h = false
		area_ataque.scale.x = 1 # Hitbox para a direita
	elif dir < 0:
		anim.flip_h = true
		area_ataque.scale.x = -1 # Hitbox para a esquerda

	# Animações
	if is_on_floor():
		# Se acabou de pousar vindo de um pulo, reseta para idle
		if anim.animation == "jump": 
			anim.play("idle")
			
		if dir != 0:
			# Correndo
			tempo_parado = 0.0
			anim.play("walk")
		else:
			# Parado (Lógica do Delay de 1s)
			tempo_parado += delta
			if tempo_parado >= 1.0:
				anim.play("idle")
			else:
				# Segura no frame 0 do idle
				if anim.animation != "idle": anim.play("idle")
				anim.set_frame_and_progress(0, 0.0)
				anim.pause()
	else:
		# No ar
		tempo_parado = 0.0
		# Só toca jump se não estiver tocando (evita loop infinito)
		if anim.animation != "jump":
			anim.play("jump")

func iniciar_ataque():
	esta_atacando = true
	atacou_neste_ciclo = false # Reseta a trava de dano
	anim.play("attack")
	attack_sound.play()

func aplicar_dano_nos_inimigos():
	# Pega todos os corpos dentro da área roxa
	var corpos = area_ataque.get_overlapping_bodies()
	
	for corpo in corpos:
		if corpo.is_in_group("inimigos"):
			if corpo.has_method("die"):
				corpo.die()
				print("Inimigo atingido!")

# Chamado automaticamente quando qualquer animação acaba
func _on_animation_finished():
	if anim.animation == "attack":
		esta_atacando = false
		anim.play("idle") # Volta para idle imediatamente

# Chamado pelo Inimigo quando ele encosta na gente
func die():
	print("Player morreu!")
	Global.coletaveis_pegos = 0
	get_tree().change_scene_to_file("res://cenas/fases/fase_lobisomen/telaDerrota.tscn")
