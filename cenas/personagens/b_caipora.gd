extends Button

func _on_pressed() -> void:
	get_node("../historia_corpo_seco").visible = true
	get_node("../CorpoSecoPixelArt2").visible = true
	get_node("../moldura_18").visible = true
	get_node("../Label_corpo_seco").visible = true
	get_node("../b_voltar_corpo_seco").visible = true
	get_node("../b_voltar_corpo_seco_obj").visible = true
