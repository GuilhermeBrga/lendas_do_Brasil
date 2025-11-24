extends Control

signal pausado
var iniciou_simon := false

func _ready() -> void:
	pausar(true)

func _on_button_pressed() -> void:
	pausar(false)
	visible = false
	pausado.emit()

	if not iniciou_simon:
		iniciou_simon = true
		$"../SimonSays".iniciar_jogo()

func pausar(pausado:bool):
	get_tree().paused = pausado


func _on_btn_duvida_aparecer_pop_up() -> void:
	visible = not visible
