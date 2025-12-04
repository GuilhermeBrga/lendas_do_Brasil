extends Node2D

var score := 0
@export var win_score := 300
#@onready var win_screen = preload("res://objects/win.tscn")
#@onready var lose_screen = preload("res://objects/lose.tscn")
#@onready var game_ui_node = $GameUI # Novo
const WIN_SCENE_PATH = "res://cenas/fases/fase_boto/objects/win.tscn"
const LOSE_SCENE_PATH = "res://cenas/fases/fase_boto/objects/lose.tscn"

const TUTORIAL_POPUP_SCENE = preload("res://cenas/fases/fase_boto/objects/tutorial_boto.tscn")

signal game_win
signal game_lose


func _ready():
	Signals.IncrementScore.connect(_on_increment_score)
	game_win.connect(_on_game_win)
	game_lose.connect(_on_game_lose)
	var tutorial_popup = TUTORIAL_POPUP_SCENE.instantiate()
	get_tree().get_root().add_child(tutorial_popup)
	tutorial_popup.tutorial_closed.connect(start_game_after_tutorial)

func start_game_after_tutorial():
	#game_ui_node.visible = true # Novo
	var level_editor_node = $LevelEditor
	if is_instance_valid(level_editor_node):
		level_editor_node.start_level()
		level_editor_node.level_finished.connect(EndGame)
	else:
		# Útil para debug se você não souber o caminho correto
		print("ERRO: Nó LevelEditor não encontrado. Verifique o caminho.")

func _on_game_win():
	#game_ui_node.visible = false # Novo
	#var w = win_screen.instantiate()
	#get_tree().get_root().add_child(w)
	#get_tree().paused = true
	if !Global.terminou_minigame_boto:
		Global.minigames_terminados -= 1
		Global.terminou_minigame_boto = true
	get_tree().paused = false
	get_tree().change_scene_to_file(WIN_SCENE_PATH)

func _on_game_lose():
	#game_ui_node.visible = false # Novo
	#var l = lose_screen.instantiate()
	#get_tree().get_root().add_child(l)
	#get_tree().paused = true
	get_tree().paused = false
	get_tree().change_scene_to_file(LOSE_SCENE_PATH)
	
func _on_increment_score(value: int):
	score += value
	print("Score:", score)
	
func EndGame():
	if score >= win_score: 
		game_win.emit()   
	else:
		game_lose.emit()   
