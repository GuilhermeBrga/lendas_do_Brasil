extends Node

signal helicoptero_morreu
const limite_para_terminar = 6

var pontos_curupira = 0
var pontos_iara = 0


var minigames_terminados = limite_para_terminar
var terminou_minigame_saci = false
var terminou_minigame_mapinguari = false
var terminou_minigame_curupira = false
var terminou_minigame_iara = false
var terminou_minigame_boto = false
var terminou_minigame_mula = false
var terminou_minigame_lobisomen = false
var terminou_minigame_mae_ouro = false

#lobisomen
var coletaveis_pegos = 0
const META_VITORIA = 3

func adicionar_coletavel():
	coletaveis_pegos += 1
	print("Coletáveis: ", coletaveis_pegos, "/", META_VITORIA)
	
	if coletaveis_pegos >= META_VITORIA:
		print("PARABÉNS! VOCÊ VENCEU!")
		minigames_terminados -= 1
		terminou_minigame_lobisomen = true
		get_tree().change_scene_to_file("res://cenas/fases/fase_lobisomen/telaVitoria.tscn")
		
func vencer_jogo():
	get_tree().paused = true
	get_tree().quit()
