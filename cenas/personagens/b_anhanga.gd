extends Button

func _on_pressed() -> void:
	get_node("../historia_anhanga").visible = true
	get_node("../AnahangaPixelArt2").visible = true
	get_node("../moldura_17").visible = true
	get_node("../Label_anhanga").visible = true
	get_node("../b_voltar_anhanga").visible = true
	get_node("../b_voltar_anhanga_obj").visible = true
