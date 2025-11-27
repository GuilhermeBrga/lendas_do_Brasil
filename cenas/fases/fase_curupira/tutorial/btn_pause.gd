extends Control
signal aparecer_pop_up_pause


func _on_texture_button_pressed() -> void:
	aparecer_pop_up_pause.emit()

func _on_curupirapause_mudar_sprite_btn() -> void:
	$TextureButton.release_focus()
