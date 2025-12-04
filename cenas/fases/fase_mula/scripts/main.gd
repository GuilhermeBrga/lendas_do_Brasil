extends Node2D

@onready var ctn = $CountDown
@onready var targetOne = $Target
@onready var targetTwo = $Target2
@onready var targetThree = $Target3
@onready var targetFour = $Target4
@onready var targetFive = $Target5
@onready var score_display_label = $ScoreDisplayLabel
const WIN_SCENE = "res://cenas/fases/fase_mula/scenes/win.tscn"
const LOSE_SCENE = "res://cenas/fases/fase_mula/scenes/lose.tscn"
const MIN_WIN_POINTS = 10

const TUTORIAL_POPUP_SCENE = preload("res://cenas/fases/fase_mula/scenes/tutorial_mula.tscn")

func _ready():
	Shared.score_updated.connect(_update_score_display)
	#startGame()
	var tutorial_popup = TUTORIAL_POPUP_SCENE.instantiate()
	get_tree().get_root().add_child(tutorial_popup)
	tutorial_popup.tutorial_closed.connect(start_game_after_tutorial)

func startGame():
	Shared.newGame()
	ctn.startCount()
	triggerTargets()

func start_game_after_tutorial():
	startGame()

func _update_score_display(new_score: int):
	score_display_label.text = "Pontos: " + str(new_score)

func _on_count_down_game_over():
	hideAllTargets()
	var final_points = Shared.endGame()
	if final_points >= MIN_WIN_POINTS:
		Global.minigames_terminados -= 1
		Global.terminou_minigame_mula = true
		get_tree().change_scene_to_file(WIN_SCENE)
	else:
		get_tree().change_scene_to_file(LOSE_SCENE)

func hideAllTargets():
	targetOne.emit_signal("forceHide")
	targetTwo.emit_signal("forceHide")
	targetThree.emit_signal("forceHide")
	targetFour.emit_signal("forceHide")
	targetFive.emit_signal("forceHide")

func triggerTargets():
	targetOne.emit_signal("triggerMe")
	await get_tree().create_timer(0.4).timeout
	targetTwo.emit_signal("triggerMe")
	await get_tree().create_timer(0.9).timeout
	targetThree.emit_signal("triggerMe")
	await get_tree().create_timer(1.4).timeout
	targetFour.emit_signal("triggerMe")
	await get_tree().create_timer(1.4).timeout
	targetFive.emit_signal("triggerMe")

func _on_restart_pressed():
	startGame()
