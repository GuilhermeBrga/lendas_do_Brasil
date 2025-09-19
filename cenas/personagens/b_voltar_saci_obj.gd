extends Button

func _on_pressed() -> void:
	get_node("../historia_saci").visible = false
	get_node("../SaciPixelArt2").visible = false
	get_node("../moldura_11").visible = false
	get_node("../Label_saci").visible = false
	get_node("../b_voltar_saci").visible = false
	get_node("../b_voltar_saci_obj").visible = false
