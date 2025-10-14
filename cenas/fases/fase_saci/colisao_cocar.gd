extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Saci":
		get_node("../Cocar").visible = false
		get_node("../Check_cocar").visible = true	
