extends Button


func _on_pressed() -> void:
	get_node("../MapinguariCutscene").visible = false
	get_node("../painel_cutscene").visible = false
	get_node("../Label_cutscene").visible = false
	get_node("../b_cutscene").visible = false
	get_node("../Setas").visible = false
