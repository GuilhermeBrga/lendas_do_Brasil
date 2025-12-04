extends Control

func _ready() -> void:
	if atingiu_limite_minigames_terminados():
		$particulas_creditos.emitting = true
	mostrar_minigames_restantes()
	mostrar_minigames_concluidos()
	mostrar_pop_up()

func mostrar_minigames_restantes():
	$personagem_restantes.text = "minigames restantes:" + str(Global.minigames_terminados)
	

func _on_b_fase_7_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fases/fase_lobisomen/intro.tscn")

func _on_b_fase_8_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fases/fase_maedeouro/Intro.tscn")

func _on_b_fase_9_pressed() -> void:
		get_tree().change_scene_to_file("res://cenas/fases/fase_anhagua/scenes/inicio.tscn")

func _on_b_creditos_pressed() -> void:
	if atingiu_limite_minigames_terminados():
		get_tree().change_scene_to_file("res://cenas/creditos/creditos.tscn")

func atingiu_limite_minigames_terminados() -> bool:
	return Global.minigames_terminados <= 0

func mostrar_minigames_concluidos():
	if Global.terminou_minigame_saci:
		$UI/concluido_saci.visible = true
	
	if Global.terminou_minigame_mapinguari:
		$UI/concluido_mapinguari.visible = true
	
	if Global.terminou_minigame_curupira:
		$UI/concluido_curupira.visible = true
	
	if Global.terminou_minigame_iara:
		$UI/concluido_iara.visible = true
	
	if Global.terminou_minigame_boto:
		$UI/concluido_boto.visible = true
	
	if Global.terminou_minigame_mula:
		$UI/concluido_mula.visible = true
	
	if Global.terminou_minigame_lobisomen:
		$UI/concluido_lobisomen.visible = true
	
	if Global.terminou_minigame_mae_ouro:
		$UI/concluido_mae_ouro.visible = true
	if Global.terminou_minigame_anhagua:
		$UI/concluido_anhagua.visible = true


func _on_button_pressed() -> void:
	$"pop-up/TextureRect".visible = false
	Global.primeira_vez_pop_up = false
	
func mostrar_pop_up():
	if 	Global.primeira_vez_pop_up:
		$"pop-up/TextureRect".visible = true
