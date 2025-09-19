extends Button

func _on_pressed() -> void:
	get_node("../historia_saci").visible = true
	get_node("../SaciPixelArt2").visible = true
	get_node("../moldura_11").visible = true
	get_node("../Label_saci").visible = true
	get_node("../b_voltar_saci").visible = true
	get_node("../b_voltar_saci_obj").visible = true
