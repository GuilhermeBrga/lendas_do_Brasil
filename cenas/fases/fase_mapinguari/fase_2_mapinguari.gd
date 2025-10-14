extends Node2D

# Cenas dos objetos
var ninho = preload("res://cenas/fases/fase_mapinguari/objetos/ninho.tscn")
var quati = preload("res://cenas/fases/fase_mapinguari/objetos/quati.tscn")
var banana = preload("res://cenas/fases/fase_mapinguari/objetos/banana.tscn")
var guarana = preload("res://cenas/fases/fase_mapinguari/objetos/guarana.tscn")
var madeira = preload("res://cenas/fases/fase_mapinguari/objetos/madeira.tscn")

var cair = false
var timer

# Array ponderado para spawn
var objetos_ponderados = []

# Configuração da gravidade individual
var gravidade_objetos = 0.3  # menor que 1 = cai devagar, maior que 1 = cai mais rápido

func _ready() -> void:
	# Criar timer
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.autostart = false
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	# Criar array ponderado: madeira aparece 3x mais
	objetos_ponderados = [
		ninho,
		quati,
		banana,
		guarana,
		madeira, madeira, madeira  # madeira 3x
	]

func spawn_objeto(posicao: Vector2):
	# Sortear objeto aleatório do array ponderado
	var objeto_scene = objetos_ponderados[randi() % objetos_ponderados.size()]
	var obj = objeto_scene.instantiate()
	obj.position = posicao
	
	# Se for RigidBody2D, ajusta a gravidade
	if obj is RigidBody2D:
		obj.gravity_scale = gravidade_objetos
	
	# Se for Area2D, faz cair manualmente (backup)
	elif obj is Area2D:
		obj.set("speed", 20)  # adiciona uma "velocidade de queda"
	
	add_child(obj)

func _on_timer_timeout():
	var screen_size = get_viewport().size
	var x = randi() % int(screen_size.x - 50)
	var y = 10  # acima da tela
	spawn_objeto(Vector2(x, y))

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_node("painel_sair").visible = !get_node("painel_sair").visible 
		get_node("moldura_sair").visible = !get_node("moldura_sair").visible 
		get_node("Label_pause").visible = !get_node("Label_pause").visible
		get_node("b_fechar_menu").visible = !get_node("b_fechar_menu").visible 
		get_node("b_fechar_menu_obj").visible = !get_node("b_fechar_menu_obj").visible
		get_node("b_salvar_prog").visible = !get_node("b_salvar_prog").visible  
		get_node("b_salvar_prog_obj").visible = !get_node("b_salvar_prog_obj").visible
		get_node("Label_aviso").visible = !get_node("Label_aviso").visible
		
		if cair:
			cair = false
			timer.stop()
		else:
			cair = true
			timer.start()

func _on_b_cutscene_pressed() -> void:
	if not cair:
		cair = true
		timer.start()


#func spawn_objeto(posicao: Vector2):
	## Sortear objeto aleatório do array ponderado
	#var objeto_scene = objetos_ponderados[randi() % objetos_ponderados.size()]
	#var obj = objeto_scene.instantiate()
	#obj.position = posicao
	#
	## Se for RigidBody2D, desliga gravidade e usa velocidade constante
	#if obj is RigidBody2D:
		#obj.gravity_scale = 0
		#obj.linear_velocity = Vector2(0, 100)  # ajusta a velocidade aqui
	#
	## Se for Area2D, adiciona velocidade fixa
	#elif obj is Area2D:
		#obj.set("speed", 100)
	#
	#add_child(obj)
