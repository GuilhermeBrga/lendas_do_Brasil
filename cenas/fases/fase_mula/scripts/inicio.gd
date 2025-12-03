extends Control

const MAIN_GAME_SCENE = "res://cenas/fases/fase_mula/scenes/main.tscn"

func _on_button_pressed():
	get_tree().change_scene_to_file(MAIN_GAME_SCENE)
