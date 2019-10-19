extends Area2D

const speed = 1000
var target
var velocity = Vector2()


func _ready():
	print("I exitst")
	target = get_global_mouse_position()
	velocity = -(position - target).normalized()
	pass

func _process(delta):
	position += velocity
