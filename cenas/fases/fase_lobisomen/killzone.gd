extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.queue_free()
		Global.coletaveis_pegos = 0
		get_tree().change_scene_to_file("res://cenas/fases/fase_lobisomen/telaDerrota.tscn")
