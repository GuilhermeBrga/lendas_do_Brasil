extends Control

func _ready() -> void:
	mostrar_minigames_restantes()

func mostrar_minigames_restantes():
	$personagem_restantes.text = "minigames restantes:" + str(Global.minigames_terminados)


func _on_b_fase_7_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fases/fase_lobisomen/intro.tscn")


func _on_b_fase_8_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/fases/fase_maedeouro/Intro.tscn")
