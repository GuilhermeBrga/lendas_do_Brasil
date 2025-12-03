extends Area2D

@onready var som = $AudioStreamPlayer2D

# Caso tenha um sprite filho, ou pode usar self.visible = false
# Se o nome do seu sprite for diferente, ajuste aqui ou use apenas hide()
@onready var sprite = $Sprite2D 
@onready var collision = $CollisionShape2D

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		
		# 1. Lógica do Global (Pontuação)
		if Global.has_method("adicionar_coletavel"):
			Global.adicionar_coletavel()
		
		# 2. TRUQUE VISUAL: Esconde o item para parecer que foi pego
		hide() # Torna este nó e todos os filhos invisíveis
		
		# 3. Desativa a colisão para não pegar o mesmo item 2 vezes enquanto o som toca
		set_deferred("monitoring", false)
		
		# 4. Toca o som e ESPERA terminar
		som.play()
		await som.finished # <--- O código pausa aqui até o som acabar
		
		# 5. Agora sim, destroi o objeto
		queue_free()
