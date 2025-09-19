extends Button

func _on_pressed() -> void:
	get_node("../historia_lobo").visible = true
	get_node("../LobisomemPixelArt2").visible = true
	get_node("../moldura_19").visible = true
	get_node("../Label_lobo").visible = true
	get_node("../b_voltar_lobo").visible = true
	get_node("../b_voltar_lobo_obj").visible = true
