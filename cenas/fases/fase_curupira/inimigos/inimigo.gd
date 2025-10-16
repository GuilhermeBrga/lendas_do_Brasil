extends Area2D

class_name Inimigo

var config:Resource

@onready var sprite = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var efeito_sonoro:AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	pass
	#sprite.texture = config.sprite_1
	#animation_player.play(config.animation_name)

func _on_area_entered(area):
	if area is BalaJogador:
		#animation_player.play("destroy")
		#efeito_sonoro.play()
		print("tome")
		area.queue_free()
		#await efeito_sonoro.finished
		queue_free()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()
