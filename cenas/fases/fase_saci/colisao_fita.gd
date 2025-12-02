extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Saci":
		get_node("../FitaVermelha").visible = false
		get_node("../Check_fita").visible = true
		$AudioStreamPlayer.play()
