extends Sprite2D

@onready var audio_surpreso:AudioStreamPlayer = $AudioSurpreso
@onready var audio_assobio:AudioStreamPlayer = $AudioAssobio
func _ready() -> void:
	$AnimatedSprite2D.play("apaixonado")

func _on_simon_says_ganhar_signal() -> void:
	audio_assobio.play()
	$CPUParticles2D.emitting = true
	await audio_assobio.finished
	get_tree().change_scene_to_file("res://cenas/fases/fase_iara/tela_vitoria.tscn")


func _on_simon_says_perder_signal() -> void:
	$AnimatedSprite2D.play("surpreso")
	audio_surpreso.play()
	await audio_surpreso.finished
	get_tree().change_scene_to_file("res://cenas/fases/fase_iara/tela_derrota.tscn")
