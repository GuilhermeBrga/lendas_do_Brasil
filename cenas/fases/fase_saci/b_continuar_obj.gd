extends Button

func _on_pressed() -> void:
	get_node("../painel_win").visible = false
	get_node("../Label_win").visible = false
	get_node("../b_continuar").visible = false
	get_node("../b_continuar_obj").visible = false
	
	get_tree().change_scene_to_file("res://cenas/mapa_fases/mapa_fases.tscn")
