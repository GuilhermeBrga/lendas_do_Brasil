extends Area2D

# --- Configurações ---
@export var velocidade: float = 350.0 # Diminuí um pouco para testar, aumente se precisar

# Esta variável receberá o valor vindo do script da Fase (Main)
var posicao_da_fogueira: Vector2 = Vector2.ZERO

# Referência ao Sprite para virar ele (ajuste o nome se o seu for AnimatedSprite2D)
@onready var sprite = $Sprite2D 
@onready var som_fogo = $AudioStreamPlayer2D

func _ready():
	# Garante que o inimigo está no grupo certo, mesmo se esqueceu de marcar na aba Node
	if not is_in_group("inimigos"):
		add_to_group("inimigos")

func _process(delta):
	# 1. SEGURANÇA: Se a posição da fogueira ainda for (0,0), não se mova.
	# Isso evita que eles corram para o canto superior esquerdo.
	if posicao_da_fogueira == Vector2.ZERO:
		return

	# 2. MOVIMENTO OTIMIZADO
	# O move_toward move o objeto da posição atual ATÉ o alvo, passo a passo.
	global_position = global_position.move_toward(posicao_da_fogueira, velocidade * delta)

	# 3. VISUAL (Espelhar o Sprite)
	# Se tiver referência ao sprite, vira ele para olhar para a fogueira
	if sprite:
		# Se a fogueira está à esquerda (<), flip_h = true. Se não, false.
		sprite.flip_h = (posicao_da_fogueira.x < global_position.x)

# --- Clique para matar ---
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		morrer()

func morrer():
	# Aqui futuramente você pode colocar som ou partícula de explosão
	queue_free()
