extends Node2D

class_name Helicoptero
signal morreu
var ta_vivo = true
@export var velocidade = 200
@export var bala_cena: PackedScene

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _process(delta: float) -> void:
	if not ta_vivo:
		return
	
	position.x -= delta * velocidade

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is BalaJogador and not $Area2D/CollisionShape2D.disabled:
		morrer()


func _on_timer_timeout() -> void:
	if not ta_vivo:
		atirar()

func atirar():
	
	var bala = bala_cena.instantiate() as BalaInimigo
	
	bala.position = global_position
	get_parent().add_child(bala)
	
func morrer():
	ta_vivo = false
	Global.helicoptero_morreu.emit()
	#inimigo_destruido.emit()
	#animation_player.play("destroy")
	$AudioStreamPlayer.play()
	#print("tome")
	$AnimatedSprite2D.visible = false
	$Area2D/CollisionShape2D.disabled = true
	emitir_particulas()
	await $AudioStreamPlayer.finished
	queue_free()

func emitir_particulas():
	$CPUParticles2D.emitting = true
