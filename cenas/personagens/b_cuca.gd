extends Button

func _on_pressed() -> void:
	get_node("../historia_mapinguari").visible = true
	get_node("../MapinguariPixelArtNoTextFinal2").visible = true
	get_node("../moldura_14").visible = true
	get_node("../Label_mapinguari").visible = true
	get_node("../b_voltar_mapinguari").visible = true
	get_node("../b_voltar_mapinguari_obj").visible = true
