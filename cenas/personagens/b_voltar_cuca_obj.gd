extends Button

func _on_pressed() -> void:
	get_node("../historia_mapinguari").visible = false
	get_node("../MapinguariPixelArtNoTextFinal2").visible = false
	get_node("../moldura_14").visible = false
	get_node("../Label_mapinguari").visible = false
	get_node("../b_voltar_mapinguari").visible = false
	get_node("../b_voltar_mapinguari_obj").visible = false
