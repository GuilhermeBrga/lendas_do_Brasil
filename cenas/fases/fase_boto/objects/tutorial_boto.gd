extends Control

signal tutorial_closed

func _ready():
	get_tree().paused = true

func _on_button_pressed():
	print("apertado")
	get_tree().paused = false
	tutorial_closed.emit()
	queue_free()
