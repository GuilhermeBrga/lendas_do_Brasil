extends Button

func _on_pressed() -> void:
	get_node("../historia_mula").visible = false
	get_node("../MulaSemCabecaPixelArt2").visible = false
	get_node("../moldura_15").visible = false
	get_node("../Label_mula").visible = false
	get_node("../b_voltar_mula").visible = false
	get_node("../b_voltar_mula_obj").visible = false
