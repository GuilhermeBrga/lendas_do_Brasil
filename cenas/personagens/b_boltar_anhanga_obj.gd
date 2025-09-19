extends Button

func _on_pressed() -> void:
	get_node("../historia_anhanga").visible = false
	get_node("../AnahangaPixelArt2").visible = false
	get_node("../moldura_17").visible = false
	get_node("../Label_anhanga").visible = false
	get_node("../b_voltar_anhanga").visible = false
	get_node("../b_voltar_anhanga_obj").visible = false
