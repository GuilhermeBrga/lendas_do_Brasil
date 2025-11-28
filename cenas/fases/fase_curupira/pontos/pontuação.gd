extends Control

var pontos = 0

func _ready() -> void:
	Global.helicoptero_morreu.connect(_on_helicoptero_morreu)

func _on_inimigo_spawn_adicionar_pontos() -> void:
	pontos += 10
	$Label.text = "pontuação: " + str(pontos)

func _on_helicoptero_morreu():
	pontos += 100
	$Label.text = "pontuação: " + str(pontos)
