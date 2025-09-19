extends Button

func _on_pressed() -> void:
	get_node("../historia_curupira").visible = true
	get_node("../CurupiraPixelArt2").visible = true
	get_node("../moldura_12").visible = true
	get_node("../Label_curupira").visible = true
	get_node("../b_voltar_curupira").visible = true
	get_node("../b_voltar_curupira_obj").visible = true
