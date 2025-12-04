extends Sprite2D

func _ready():
	await get_tree().process_frame  # garante que a viewport já carregou
	
	if not texture:
		return

	var vp = get_viewport_rect().size
	var tex_size = texture.get_size()

	var scale_factor = max(vp.x / tex_size.x, vp.y / tex_size.y)
	scale = Vector2(scale_factor, scale_factor)

	# Centraliza o sprite na tela
	position = vp / 2
