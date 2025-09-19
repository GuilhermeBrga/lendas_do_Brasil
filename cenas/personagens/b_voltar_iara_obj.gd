extends Button



func _on_pressed() -> void:
	get_node("../historia_iara").visible = false
	get_node("../IaraPixelArt2").visible = false
	get_node("../moldura_13").visible = false
	get_node("../Label_iara").visible = false
	get_node("../b_voltar_iara").visible = false
	get_node("../b_voltar_iara_obj").visible = false
