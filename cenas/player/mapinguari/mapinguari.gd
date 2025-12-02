extends CharacterBody2D

@export var speed: float = 200.0
@onready var anim_sprite = $AnimatedSprite2D
@onready var label_pontos: Label = get_parent().get_node("Label_pontos")

@onready var logica_fase = get_parent() 

var pontos := 0
var ultima_direcao := "baixo"
var coletados = []
var pode_perder_vida := true 


var colisores_processados := {}


func _ready():
	if label_pontos == null:
		push_error("Label_pontos NÃO encontrada.")
	else:
		if label_pontos.text.strip_edges() != "":
			pontos = int(label_pontos.text)
		label_pontos.text = str(pontos)



func _physics_process(delta):

	colisores_processados.clear()  # limpa no início de cada frame

	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

	if logica_fase.cair == false:
		return

	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				anim_sprite.play("walk_direita")
			else:
				anim_sprite.play("walk_esquerda")
		else:
			if direction.y > 0:
				anim_sprite.play("walk_baixo")
				ultima_direcao = "baixo"
			else:
				anim_sprite.play("walk_cima")
				ultima_direcao = "cima"
	else:
		match ultima_direcao:
			"baixo":
				anim_sprite.play("idle_frente")
			"cima":
				anim_sprite.play("idle_costas")

	verificar_colisoes()


func toggle_pause():
	var root = logica_fase

	root.get_node("painel_sair").visible = !root.get_node("painel_sair").visible 
	root.get_node("moldura_sair").visible = !root.get_node("moldura_sair").visible 
	root.get_node("Label_pause").visible = !root.get_node("Label_pause").visible
	root.get_node("b_fechar_menu").visible = !root.get_node("b_fechar_menu").visible 
	root.get_node("b_fechar_menu_obj").visible = !root.get_node("b_fechar_menu_obj").visible
	root.get_node("b_salvar_prog").visible = !root.get_node("b_salvar_prog").visible  
	root.get_node("b_salvar_prog_obj").visible = !root.get_node("b_salvar_prog_obj").visible
	root.get_node("Label_aviso").visible = !root.get_node("Label_aviso").visible

	if root.cair:
		root.cair = false
		root.timer.stop()
	else:
		root.cair = true
		root.timer.start()



func verificar_colisoes():
	var total = get_slide_collision_count()

	for i in range(total):
		var colisao = get_slide_collision(i)
		if not colisao:
			continue

		var objeto = colisao.get_collider()
		if not objeto:
			continue

		# impede perder colisões no mesmo frame
		var id = objeto.get_instance_id()
		if colisores_processados.has(id):
			continue
		colisores_processados[id] = true

		var nome = objeto.name.to_lower()

		# coleta itens
		if nome in ["ninho", "quati", "banana", "guarana"]:
			if objeto in coletados:
				continue
			coletados.append(objeto)

			pontos += 1
			label_pontos.text = str(pontos)
			$AudioStreamPlayer2.play()

			if objeto.is_inside_tree():
				objeto.set_deferred("collision_layer", 0)
				objeto.set_deferred("collision_mask", 0)
				objeto.queue_free()

		# dano
		elif nome == "madeira" and pode_perder_vida:
			reduzir_vida()
			pode_perder_vida = false
			aguardar_invulnerabilidade()



# garante invulnerabilidade real
func aguardar_invulnerabilidade():
	await get_tree().create_timer(0.8).timeout
	pode_perder_vida = true



func reduzir_vida():
	var full = get_node("../FullLife")
	var mid = get_node("../MidLife")
	var low = get_node("../LowLife")
	var dead = get_node("../DeadLife")

	if full.visible:
		full.visible = false
		mid.visible = true
		$AudioStreamPlayer.play()
	elif mid.visible:
		mid.visible = false
		low.visible = true
		$AudioStreamPlayer.play()
	elif low.visible:
		low.visible = false
		dead.visible = true

	if dead.visible:
		get_node("../painel_vitoria").visible = true
		get_node("../moldura_vitoria").visible = true
		get_node("../Estrela1").visible = true
		get_node("../Estrela2").visible = true
		get_node("../Estrela3").visible = true
		get_node("../Label_vitoria").visible = true
		get_node("../B_vitoria").visible = true
		get_node("../B_vitoria_img").visible = true
		$AudioStreamPlayer3.play()
		logica_fase.cair = false
		logica_fase.timer.stop()
