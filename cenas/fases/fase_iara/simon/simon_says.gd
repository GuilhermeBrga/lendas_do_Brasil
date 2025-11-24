extends Node2D

@onready var texto:Label = $Panel/Label
@onready var butoes = [
	$Panel/btn_verde,
	$Panel/btn_vermelho,
	$Panel/btn_amarelo,
	$Panel/btn_azul
]

@onready var butoes_sfx = [
	$Panel/btn_verde/AudioStreamPlayer,
	$Panel/btn_vermelho/AudioStreamPlayer,
	$Panel/btn_amarelo/AudioStreamPlayer,
	$Panel/btn_azul/AudioStreamPlayer
]

var padrao: Array[int] = []
var show_speed: float = 0.5
var currentPatternIndex: int = 0
var playerTurn: bool = false
var gameStarted: bool = false
var rodadas:int = 5
var ganhou:bool = false
var perdeu:bool = false

signal perder_signal
signal ganhar_signal

func _ready() -> void:
	randomize()
	texto.text = "RODADAS RESTANTES: " + str(rodadas)

func travar_butoes():
	for butao:TextureButton in butoes:
		butao.disabled = true

func destravar_butoes():
	for butao:TextureButton in butoes:
		butao.disabled = false

func iniciar_jogo():
	gameStarted = true
	proxima_cor()
	await mostrar_sequencia()

func proxima_cor():
	padrao.append(randi() % butoes.size())

func mostrar_sequencia():
	travar_butoes()
	await get_tree().create_timer(show_speed).timeout
	
	for idx in padrao:
		piscar(butoes[idx], false)
		await emitir_som(butoes_sfx[idx])
		piscar(butoes[idx], true)
		await get_tree().create_timer(show_speed/2).timeout
	
	destravar_butoes()
	currentPatternIndex = 0
	playerTurn = true

func input_jogador(butao:int):
	if not gameStarted and not ganhou:
		await get_tree().create_timer(show_speed*4).timeout
		gameStarted = true
		proxima_cor()
		await mostrar_sequencia()
	
	if playerTurn:
		if butao == padrao[currentPatternIndex]:
			if currentPatternIndex + 1 == padrao.size():
				await success()
			else:
				currentPatternIndex += 1
		else:
			game_over()

func success() -> void:
	atualizar_texto()
	ganhar_simon()

	if ganhou:
		return

	playerTurn = false
	proxima_cor()
	await mostrar_sequencia()

func game_over():
	if not ganhou and not perdeu:
		perder()

func piscar(butao: TextureButton, valor: bool):
	butao.disabled = valor
	butao.visible = valor

func emitir_som(butao_sfx:AudioStreamPlayer) -> void:
	butao_sfx.play()
	await butao_sfx.finished

func atualizar_texto():
	diminuir_rodada()
	texto.text = "RODADAS RESTANTES: " + str(rodadas)

func diminuir_rodada():
	rodadas -= 1

func ganhar_simon():
	if rodadas == 5:
		ganhar()
		return

func ganhar():
	if ganhou:
		return
	ganhou = true
	playerTurn = false
	gameStarted = false
	ganhar_signal.emit()


func perder():
	if perdeu:
		return
	perdeu = true
	playerTurn = false
	gameStarted = false
	perder_signal.emit()

func _on_btn_verde_pressed():
	input_jogador(0)

func _on_btn_vermelho_pressed():
	input_jogador(1)

func _on_btn_amarelo_pressed():
	input_jogador(2)

func _on_btn_azul_pressed():
	input_jogador(3)
