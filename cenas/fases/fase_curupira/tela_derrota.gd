extends Control

func _ready() -> void:
	mostrar_pontos()

func mostrar_pontos():
	$fundo_label_pontos/label_pontos.text = "pontos: " + str(Global.pontos_curupira)

func _on_btn_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/mapa_fases/mapa_fases.tscn")
