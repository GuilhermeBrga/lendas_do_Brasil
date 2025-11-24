extends Control

signal pausado

func _ready() -> void:
	pausar(true)

func _on_button_pressed() -> void:
	pausar(false)
	visible = false
	pausado.emit()

func pausar(pausado:bool):
	get_tree().paused = pausado

func _on_btn_duvida_aparecer_pop_up() -> void:
	visible = not visible
	pausar(true)
