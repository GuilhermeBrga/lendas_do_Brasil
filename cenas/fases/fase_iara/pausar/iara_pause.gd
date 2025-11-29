extends Control

signal mudar_sprite_btn

func _ready() -> void:
	#$TextureRect/Button.disabled = true
	pass

func _on_button_pressed() -> void:
	visible = false
	pausar(false)
	mudar_sprite_btn.emit()

func pausar(pausado:bool):
	get_tree().paused = pausado

func _on_btn_pausar_aparecer_pop_up_pause() -> void:
	visible = not visible
	$TextureRect/Button.disabled = false
	pausar(true)
