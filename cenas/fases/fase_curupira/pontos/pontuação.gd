extends Control

func _ready() -> void:
	Global.helicoptero_morreu.connect(_on_helicoptero_morreu)

func _on_inimigo_spawn_adicionar_pontos() -> void:
	Global.pontos_curupira += 10
	$Label.text = "pontuação: " + str(Global.pontos_curupira)

func _on_helicoptero_morreu():
	Global.pontos_curupira += 100
	$Label.text = "pontuação: " + str(Global.pontos_curupira)
