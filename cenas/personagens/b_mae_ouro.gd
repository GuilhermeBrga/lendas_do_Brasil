extends Button

func _on_pressed() -> void:
	get_node("../historia_mae_ouro").visible = true
	get_node("../MaeDeOuroPixelArt2").visible = true
	get_node("../moldura_16").visible = true
	get_node("../Label_mae_ouro").visible = true
	get_node("../b_voltar_mae_ouro").visible = true
	get_node("../b_voltar_mae_ouro_obj").visible = true
