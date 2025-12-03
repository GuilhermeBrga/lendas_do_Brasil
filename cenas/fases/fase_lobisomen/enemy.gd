extends CharacterBody2D

const SPEED = 40.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

var pode_verificar = true

@onready var ray_cast = $RayCast2D
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Verificação de borda/parede
	if pode_verificar:
		if is_on_wall() or (is_on_floor() and not ray_cast.is_colliding()):
			virar()

	# Movimento
	velocity.x = direction * SPEED
	move_and_slide()


func virar():
	pode_verificar = false

	direction *= -1

	# Inverte sprite
	sprite.flip_h = direction < 0

	# Inverte RayCast DA FORMA CORRETA
	ray_cast.target_position.x = abs(ray_cast.target_position.x) * direction

	# Delay para não virar enlouquecidamente
	await get_tree().create_timer(0.4).timeout
	pode_verificar = true
	
func die():
	sprite.play("death")
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die() # Replace with function body.
