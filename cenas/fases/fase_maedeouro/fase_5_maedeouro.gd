extends Node2D

var cena_inimigo = preload("res://cenas/fases/fase_maedeouro/enemy.tscn")

# Referências aos nós (Garanta que os nomes na cena são iguais a estes)
@onready var fogueira = $Fogueira 
@onready var spawn_point = $SpawnPoint 
@onready var timer_spawn = $Timer        # O Timer que cria os inimigos
@onready var timer_vitoria = $TimerVitoria # O Timer de 30 segundos (Vitória)
@onready var texto_timer:Label = $Label

func _ready():
	# INICIA TUDO DIRETO (Sem tutorial, sem pausa)
	randomize() # Garante que os números sejam aleatórios de verdade
	timer_spawn.start()
	timer_vitoria.start()
	print("Jogo começou! Sobreviva por " + str(timer_vitoria.wait_time) + " segundos.")
	atualizar_texto_timer()

func _process(delta):
	atualizar_texto_timer()

# --- SPAWN DE INIMIGOS ---
func _on_timer_timeout() -> void:
	spawnar_inimigo()
	# Muda o tempo do próximo spawn para ficar dinâmico
	timer_spawn.wait_time = randf_range(1.5, 3.5)

func spawnar_inimigo():
	var novo_inimigo = cena_inimigo.instantiate()
	
	# Posição aleatória na boca da caverna
	var offset_x = randf_range(-80, 80)
	var offset_y = randf_range(-80, 80)
	var pos_final = spawn_point.global_position + Vector2(offset_x, offset_y)
	
	novo_inimigo.global_position = pos_final
	novo_inimigo.posicao_da_fogueira = fogueira.global_position
	
	add_child(novo_inimigo)

# --- LÓGICA DE VITÓRIA ---
func _on_timer_vitoria_timeout() -> void:
	vitoria()

func vitoria():
	print("TEMPO ESGOTADO - VOCÊ VENCEU!")
	
	# 1. Para de nascer novos inimigos
	timer_spawn.stop()
	
	# 2. Limpa a tela (remove os inimigos atuais)
	get_tree().call_group("inimigos", "queue_free")
	
	# 3. Troca para a cena de vitória (usando call_deferred para evitar erros de física)
	call_deferred("trocar_para_vitoria")

func trocar_para_vitoria():
	# Verifique se este caminho de arquivo está correto!
	if Global.terminou_minigame_mae_ouro:
		Global.minigames_terminados -= 1
		Global.terminou_minigame_mae_ouro = true
	get_tree().change_scene_to_file("res://cenas/fases/fase_maedeouro/telaVitoria.tscn")

func atualizar_texto_timer():
	var tempo = int(timer_vitoria.time_left)
	texto_timer.text = "tempo restante: " + str(tempo) + "s"
