extends Area2D
class_name BalaInimigo

@export var VELOCIDADE: float = 200
@export_enum("CIMA", "BAIXO") var direcao: String = "CIMA"
@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	# Movimento da bala
	if direcao == "CIMA":
		position.y -= VELOCIDADE * delta
	else:
		position.y += VELOCIDADE * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Jogador and body.ta_vivo:
		body.morrer()
