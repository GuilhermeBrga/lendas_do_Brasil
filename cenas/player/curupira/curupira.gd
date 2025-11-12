extends CharacterBody2D

class_name Jogador

@export var speed = 400
@export var bala_cena: PackedScene
var pode_atirar = true

func get_input():
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	velocity.x = direction * speed

func _physics_process(delta):
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
