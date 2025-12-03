extends Area2D

# Configuração da Vida
var vida_maxima = 3
var vida_atual = 3

func _ready():
	vida_atual = vida_maxima

func _on_area_entered(area):
	# Verifica se o objeto é inimigo
	if area.is_in_group("inimigos"):
		print("Inimigo atingiu a fogueira!")
		
		# 1. Destrói o inimigo (ele cumpre o objetivo dele e some)
		area.queue_free()
		
		# 2. Fogueira toma dano
		tomar_dano()

func tomar_dano():
	vida_atual -= 1
	print("Vida restante da fogueira: ", vida_atual)
	
	if vida_atual <= 0:
		game_over()

func game_over():
	print("GAME OVER - Fogueira apagou!")
	
	get_tree().change_scene_to_file("res://cenas/fases/fase_maedeouro/TelaDerrota.tscn")
