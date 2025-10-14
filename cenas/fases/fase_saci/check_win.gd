extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Saci":
		if get_node("../Check_fita").visible == true and get_node("../Check_cachimbo").visible == true and get_node("../Check_cocar").visible == true and get_node("../Check_tambor").visible == true:
			
			var parede = get_node("../parede_win")
			
			if parede.has_node("CollisionShape2D"):
				parede.get_node("CollisionShape2D").call_deferred("set_deferred", "disabled", true)
