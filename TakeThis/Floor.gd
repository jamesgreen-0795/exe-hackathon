extends StaticBody2D

export (bool) var is_end = false
export (bool) var is_right = true

func _ready():
	if is_end:
		get_node("Sprite").hide()
		get_node("SpriteFloorEnd").show()
		if not is_right:
			get_node("SpriteFloorEnd").set_flip_h(true)