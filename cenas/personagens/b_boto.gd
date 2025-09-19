extends Button

func _on_pressed() -> void:
	get_node("../historia_boto").visible = true
	get_node("../BotoAnimalChapeuPixelArt2").visible = true
	get_node("../moldura_21").visible = true
	get_node("../Label_boto").visible = true
	get_node("../b_voltar_boto").visible = true
	get_node("../b_voltar_boto_obj").visible = true
