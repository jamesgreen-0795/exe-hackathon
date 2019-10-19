extends Area2D

const speed = 10
var target
var velocity = Vector2()

func _ready():
	target = get_global_mouse_position()
	
	velocity = (target - global_position).normalized()
	pass

func _process(delta):
	position += velocity * speed


func _on_BasicBullet_body_entered(body):
	print_debug("fuck yeah bois")
