extends CharacterBody2D

@export var speed: float = 200.0
@onready var anim_sprite = $AnimatedSprite2D

var ultima_direcao := "baixo"  # começa olhando para frente

func _physics_process(delta):
	var direction = Vector2.ZERO

	# Movimento básico
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normaliza a direção
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()

		# Escolhe animação dependendo da direção
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				anim_sprite.play("walk_direita")
			else:
				anim_sprite.play("walk_esquerda")
		else:
			if direction.y > 0:
				anim_sprite.play("walk_cima")
				ultima_direcao = "baixo"
			else:
				anim_sprite.play("walk_baixo")
				ultima_direcao = "cima"
	else:
		velocity = Vector2.ZERO

		# Toca idle de acordo com a última direção
		match ultima_direcao:
			"baixo":
				anim_sprite.play("idle_frente")
			"cima":
				anim_sprite.play("idle_costas")
			"direita":
				anim_sprite.play("idle_direita")
			"esquerda":
				anim_sprite.play("idle_esquerda")
