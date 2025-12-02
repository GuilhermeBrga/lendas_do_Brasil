extends Button



func _on_pressed() -> void:
	get_node("../painel_vitoria").visible = false
	get_node("../moldura_vitoria").visible = false
	get_node("../Estrela1").visible = false
	get_node("../Estrela2").visible = false
	get_node("../Estrela3").visible = false
	get_node("../Label_vitoria").visible = false
	get_node("../B_vitoria").visible = false
	get_node("../B_vitoria_img").visible = false
	
	get_tree().change_scene_to_file("res://cenas/mapa_fases/mapa_fases.tscn")
