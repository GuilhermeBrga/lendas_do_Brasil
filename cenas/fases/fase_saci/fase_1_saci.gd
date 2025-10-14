extends Node2D

func _process(delta):
	# Menu pause
	if Input.is_action_just_pressed("ui_cancel"):
		get_node("painel_sair").visible = !get_node("painel_sair").visible 
		get_node("moldura_sair").visible = !get_node("moldura_sair").visible 
		get_node("Label_pause").visible = !get_node("Label_pause").visible
		get_node("b_fechar_menu").visible = !get_node("b_fechar_menu").visible 
		get_node("b_fechar_menu_obj").visible = !get_node("b_fechar_menu_obj").visible
		get_node("b_salvar_prog").visible = !get_node("b_salvar_prog").visible  
		get_node("b_salvar_prog_obj").visible = !get_node("b_salvar_prog_obj").visible
		get_node("Label_aviso").visible = !get_node("Label_aviso").visible
