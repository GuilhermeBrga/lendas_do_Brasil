extends Area2D

@export var VIDA = 10
var metade_vida = VIDA / 2

@onready var label:Label = $Label

func _ready() -> void:
	atualizar_vida()

func _on_area_entered(area: Area2D) -> void:
	if area is BalaInimigo or area is BalaJogador:
		area.queue_free()
		VIDA-=1
		atualizar_vida()
		ta_vivo()
		$AudioStreamPlayer.play()
		atualizar_sprites()

	elif area is Inimigo:
		queue_free()

func ta_vivo():
	if VIDA <= 0:
		queue_free()
		
func atualizar_vida():
	label.text = "vida: " + str(VIDA)
	
func atualizar_sprites():
	if  VIDA > metade_vida:
		$AnimatedSprite2D.play("vida-cheia")
	else:
		$AnimatedSprite2D.play("morrendo")
