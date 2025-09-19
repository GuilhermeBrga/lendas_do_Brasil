extends Button


func _on_pressed() -> void:
	get_node("../historia_iara").visible = true
	get_node("../IaraPixelArt2").visible = true
	get_node("../moldura_13").visible = true
	get_node("../Label_iara").visible = true
	get_node("../b_voltar_iara").visible = true
	get_node("../b_voltar_iara_obj").visible = true
