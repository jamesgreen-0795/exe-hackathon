extends RigidBody2D

const speed = 500
var target
var velocity = Vector2()
var itemType
var scene = preload("res://BulletParticles.tscn")

func _ready():
	target = get_global_mouse_position()
	contact_monitor = true
	contacts_reported = true
	linear_velocity = (target - global_position).normalized() * speed
	pass


func _on_BasicBullet_body_entered(body):
	var particles = scene.instance()
	particles.position = position
	get_parent().add_child(particles)
	particles.emitting = true
	
	if !(body.name == "Player"):
		queue_free()
	if body is Enemy:
		if itemType == "antigrav":
			body.remove_gravity()
		else:
			body.die()
