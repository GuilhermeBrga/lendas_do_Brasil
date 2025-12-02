extends Node2D

@export var LINHAS = 5
@export var COLUNAS = 11
#const LINHAS = 5
#const COLUNAS  = 11
const ESPACAMENTO_HORIZONTAL = 32
const ESPACAMENTO_VERTICAL = 32
const ALTURA_INIMIGOS = 24

var inimigo_cena
const POSICAO_INICIAL_Y = -50

const INIMIGOS_POSICAO_X_INCREMENTAR = 20
const INIMIGOS_POSICAO_Y_INCREMENTAR = 20
var direcao_movimento = 1
var inimigos_vivos = 0

@onready var movimento_timer: Timer = $movimento_timer
@onready var tiro_timer: Timer = $tiro_timer

var tiro_inimigo_cena = preload("res://cenas/fases/fase_curupira/assets/projeteis/inimigo/caçador/bala_inimigo.tscn")
var inimigos_totais = LINHAS * COLUNAS

signal adicionar_pontos
signal ganhou
signal perdeu

func _ready() -> void:
	movimento_timer.timeout.connect(mover_inimigos)
	tiro_timer.timeout.connect(tiro_inimigo)
	
	inimigo_cena = preload("inimigo.tscn")
	
	var inimigo_configuracao
	for linha in LINHAS:
		var inimigo_1_res = preload("res://cenas/fases/fase_curupira/resources/inimigo1.tres")
		var inimigo_2_res = preload("res://cenas/fases/fase_curupira/resources/inimigo2.tres")
		var inimigo_3_res = preload("res://cenas/fases/fase_curupira/resources/inimigo3.tres")
		
		if linha == 0:
			inimigo_configuracao = inimigo_1_res
			inimigo_configuracao = inimigo_1_res
		elif  linha == 1 || linha == 2:
			inimigo_configuracao = inimigo_2_res
		elif linha == 3 || linha == 4:
			inimigo_configuracao = inimigo_3_res
			
		var linha_largura = (COLUNAS * inimigo_configuracao.width * 3) + ((COLUNAS - 1) * ESPACAMENTO_HORIZONTAL)
		var posicao_inicial_x = (position.x - linha_largura) / 2
		
		for coluna in COLUNAS:
			var x = posicao_inicial_x + (coluna * inimigo_configuracao.width * 3) + (coluna * ESPACAMENTO_HORIZONTAL)
			var y = POSICAO_INICIAL_Y + (linha * ALTURA_INIMIGOS) + (linha * ESPACAMENTO_VERTICAL)
			
			var posicao_spawn = Vector2(x, y)
			adicionar_inimigo(inimigo_configuracao, posicao_spawn)
			
func adicionar_inimigo(inimigo_configuracao,posicao_spawn:Vector2):
	var inimigo = inimigo_cena.instantiate() as Inimigo
	inimigo.config = inimigo_configuracao
	inimigo.global_position = posicao_spawn
	inimigo.inimigo_destruido.connect(verificar_inimigos)
	#inimigo.
	add_child(inimigo)
	inimigos_vivos+=1

func verificar_inimigos():
	inimigos_vivos -= 1
	adicionar_pontos.emit()
	if inimigos_vivos <= 0:
		ganhou.emit()

func mover_inimigos():
	position.x += INIMIGOS_POSICAO_X_INCREMENTAR * direcao_movimento

func tiro_inimigo():
	var inimigos = get_children().filter(func (filho): return filho is Inimigo)
	if inimigos.is_empty():
		return # não atira se não houver inimigos

	var inimigo_aleatorio = inimigos.pick_random()
	
	var tiro_inimigo = tiro_inimigo_cena.instantiate() as BalaInimigo
	tiro_inimigo.global_position = inimigo_aleatorio.global_position
	get_parent().add_child(tiro_inimigo)


func _on_parede_esquerda_area_entered(area: Area2D) -> void:
	if direcao_movimento == -1 and area is Inimigo:
		position.y += INIMIGOS_POSICAO_Y_INCREMENTAR
		direcao_movimento *= -1

func _on_parede_direita_area_entered(area: Area2D) -> void:
	if direcao_movimento == 1 and area is Inimigo:
		position.y += INIMIGOS_POSICAO_Y_INCREMENTAR
		direcao_movimento *= -1

func _on_chao_area_entered(area: Area2D) -> void:
	if area is Inimigo:
		perdeu.emit()
		# PERDER
		#get_tree().change_scene_to_file("res://cenas/fases/fase_curupira/tela_derrota.tscn")
		##get_tree().paused = true
		#print("acabou") # Replace with function body.
