extends CharacterBody2D

class_name Jogador

@onready var audio_grito:AudioStreamPlayer = $sons/audio_grito
@onready var audio_vitoria:AudioStreamPlayer = $sons/audio_vitoria
@onready var audio_derrota:AudioStreamPlayer = $sons/audio_derrota
@onready var particulas_sangue:CPUParticles2D = $particulas_sangue
@onready var particulas_vitoria:CPUParticles2D = $particulas_vitoria
@export var speed = 400
@export var bala_cena: PackedScene

var pode_atirar = true
var ta_vivo = true

func get_input():
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	velocity.x = direction * speed

func _physics_process(delta):
	if ta_vivo:
		get_input()
		move_and_slide()
	
	# Disparo
		if Input.is_action_just_pressed("ui_ação"):  # Espaço por padrão
			atirar()

func atirar():
	if bala_cena and pode_atirar:
		pode_atirar = false
		var bala = bala_cena.instantiate() as BalaJogador
		bala.position = global_position + Vector2(20, 0)
		get_parent().add_child(bala)
		
		bala.connect("tree_exited", Callable(self, "bala_sumiu"))
		
		$AnimatedSprite2D.play("lançar")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("idle")

func bala_sumiu():
	pode_atirar = true
	
func morrer():
	emitir_particulas_sangue(true)
	ta_vivo = false
	audio_grito.play()
	$CollisionShape2D.disabled = true
	await audio_grito.finished
	get_tree().change_scene_to_file("res://cenas/fases/fase_curupira/tela_derrota.tscn")

func _on_inimigo_spawn_ganhou() -> void:
	if !Global.terminou_minigame_curupira:
		print("foi")
		Global.minigames_terminados -= 1
		Global.terminou_minigame_curupira = true
	vitoria_animacao()
	

func derrota_animacao():
	ta_vivo = false
	$AnimatedSprite2D.play("derrota")
	audio_derrota.play()
	await audio_derrota.finished
	get_tree().change_scene_to_file("res://cenas/fases/fase_curupira/tela_derrota.tscn")

func vitoria_animacao():
	ta_vivo = false
	$AnimatedSprite2D.play("vitoria")
	emitir_particulas_vitoria(true)
	audio_vitoria.play()
	await audio_vitoria.finished
	get_tree().change_scene_to_file("res://cenas/fases/fase_curupira/tela_vitoria.tscn")

func emitir_particulas_sangue(pode_emitir:bool):
	particulas_sangue.emitting = pode_emitir

func emitir_particulas_vitoria(pode_emitir:bool):
	particulas_vitoria.emitting = pode_emitir

func _on_inimigo_spawn_perdeu() -> void:
	derrota_animacao()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Inimigo:
		morrer()
