extends Button

func _on_pressed() -> void:
	get_node("../historia_lobo").visible = false
	get_node("../LobisomemPixelArt2").visible = false
	get_node("../moldura_19").visible = false
	get_node("../Label_lobo").visible = false
	get_node("../b_voltar_lobo").visible = false
	get_node("../b_voltar_lobo_obj").visible = false
