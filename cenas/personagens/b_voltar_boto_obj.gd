extends Button

func _on_pressed() -> void:
	get_node("../historia_boto").visible = false
	get_node("../BotoAnimalChapeuPixelArt2").visible = false
	get_node("../moldura_21").visible = false
	get_node("../Label_boto").visible = false
	get_node("../b_voltar_boto").visible = false
	get_node("../b_voltar_boto_obj").visible = false
