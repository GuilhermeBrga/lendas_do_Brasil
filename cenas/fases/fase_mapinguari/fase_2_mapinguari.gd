extends Node2D

var ninho = preload("res://cenas/fases/fase_mapinguari/objetos/ninho.tscn")
var quati = preload("res://cenas/fases/fase_mapinguari/objetos/quati.tscn")
var banana = preload("res://cenas/fases/fase_mapinguari/objetos/banana.tscn")
var guarana = preload("res://cenas/fases/fase_mapinguari/objetos/guarana.tscn")
var madeira = preload("res://cenas/fases/fase_mapinguari/objetos/madeira.tscn")

var cair = false
var timer

var objetos_ponderados = []

var gravidade_objetos = 0.3 

func _ready() -> void:
	# Criar timer
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = false
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	objetos_ponderados = [
		ninho,
		quati,
		banana,
		guarana,
		madeira, 
		madeira, 
		madeira 
	]

func spawn_objeto(posicao: Vector2):
	var objeto_scene = objetos_ponderados[randi() % objetos_ponderados.size()]
	var obj = objeto_scene.instantiate()
	obj.position = posicao

	if obj is RigidBody2D:
		obj.gravity_scale = gravidade_objetos
	
	elif obj is Area2D:
		obj.set("speed", 20)
	
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


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
