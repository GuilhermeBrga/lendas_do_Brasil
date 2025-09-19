extends Button

func _on_pressed() -> void:
	get_node("../historia_corpo_seco").visible = false
	get_node("../CorpoSecoPixelArt2").visible = false
	get_node("../moldura_18").visible = false
	get_node("../Label_corpo_seco").visible = false
	get_node("../b_voltar_corpo_seco").visible = false
	get_node("../b_voltar_corpo_seco_obj").visible = false
