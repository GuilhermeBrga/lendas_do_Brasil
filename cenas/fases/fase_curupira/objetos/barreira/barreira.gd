extends Area2D

@export var VIDA = 15
@onready var label:Label = $Label

func _ready() -> void:
	atualizar_vida()

func _on_area_entered(area: Area2D) -> void:
	if area is BalaInimigo or BalaJogador:
		area.queue_free()
		VIDA-=1
		atualizar_vida()
		ta_vivo()

func ta_vivo():
	if VIDA <= 0:
		queue_free()
		
func atualizar_vida():
	label.text = "vida: " + str(VIDA)	
