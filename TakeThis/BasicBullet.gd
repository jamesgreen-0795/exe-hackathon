extends RigidBody2D

const speed = 500
var target
var velocity = Vector2()

func _ready():
	target = get_global_mouse_position()
	contact_monitor = true
	contacts_reported = true
	linear_velocity = (target - global_position).normalized() * speed
	pass


func _on_BasicBullet_body_entered(body):
	if !(body.name == "Player"):
		queue_free()
	if body is Enemy:
		body.die()
