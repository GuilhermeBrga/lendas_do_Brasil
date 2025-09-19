extends Button

func _on_pressed() -> void:
	get_node("../historia_curupira").visible = false
	get_node("../CurupiraPixelArt2").visible = false
	get_node("../moldura_12").visible = false
	get_node("../Label_curupira").visible = false
	get_node("../b_voltar_curupira").visible = false
	get_node("../b_voltar_curupira_obj").visible = false
