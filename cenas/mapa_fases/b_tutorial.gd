extends Button

var visivel: bool = false

func _on_pressed() -> void:
	
	if visivel == false:
		get_node("../tutorial").visible = true
		get_node("../Label_tutorial").visible = true
		visivel = true
	
	else:
		get_node("../tutorial").visible = false
		get_node("../Label_tutorial").visible = false
		visivel = false
