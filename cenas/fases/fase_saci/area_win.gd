extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Saci":
		get_node("../painel_win").visible = true
		get_node("../Label_win").visible = true
		get_node("../b_continuar").visible = true
		get_node("../b_continuar_obj").visible = true
		get_node("../Estrela1").visible = true
		get_node("../Estrela2").visible = true
		get_node("../Estrela3").visible = true
		
		get_node("../Estrela_win").visible = false
