extends Button


func _on_pressed() -> void:
	get_node("../SaciCutscenePixelArt").visible = false
	get_node("../painel_cutscene").visible = false
	get_node("../Label_cutscene").visible = false
	get_node("../b_cutscene").visible = false
	get_node("../Setas").visible = false
	
	get_node("../area_win").visible = true
	get_node("../Estrela_win").visible = true
	get_node("../parede_win").visible = true
	get_node("../check_win").visible = true
