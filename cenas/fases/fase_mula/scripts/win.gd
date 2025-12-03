extends Control

#const START_GAME_SCENE = "res://cenas/fases/fase_mula/scenes/inicio.tscn"

func _on_button_pressed():
	get_tree().change_scene_to_file("res://cenas/mapa_fases/mapa_fases.tscn")
