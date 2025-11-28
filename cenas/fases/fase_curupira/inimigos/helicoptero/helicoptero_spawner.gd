extends Node2D

@export var helicoptero_cena: PackedScene
func _on_timer_timeout() -> void:
	criar_helicoptero()

func criar_helicoptero():
	var helicoptero = helicoptero_cena.instantiate() as Helicoptero
	
	helicoptero.position = global_position + Vector2(20, 0)
	get_parent().add_child(helicoptero)
