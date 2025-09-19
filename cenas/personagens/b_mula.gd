extends Button


func _on_pressed() -> void:
	get_node("../historia_mula").visible = true
	get_node("../MulaSemCabecaPixelArt2").visible = true
	get_node("../moldura_15").visible = true
	get_node("../Label_mula").visible = true
	get_node("../b_voltar_mula").visible = true
	get_node("../b_voltar_mula_obj").visible = true
