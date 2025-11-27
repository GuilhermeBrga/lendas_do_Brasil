extends Control
signal aparecer_pop_up

func _on_texture_button_pressed() -> void:
	aparecer_pop_up.emit()
