extends Button

func _on_pressed() -> void:
	get_node("../painel_sair").visible = false
	get_node("../moldura_sair").visible = false
	get_node("../Label_pause").visible = false
	get_node("../b_fechar_menu").visible = false
	get_node("../b_fechar_menu_obj").visible = false
	get_node("../b_salvar_prog").visible = false 
	get_node("../b_salvar_prog_obj").visible = false
	get_node("../Label_aviso").visible = false 
