extends StaticBody2D

export (bool) var is_right = true

func _ready():
	if is_right:
		rotation_degrees = 90