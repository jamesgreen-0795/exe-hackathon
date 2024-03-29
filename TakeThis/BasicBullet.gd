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

func setItemType(type):
	itemType = type
	
	get_node("SpriteSpoonBullet").visible = false
	get_node("SpriteFireballBullet").visible = false
	get_node("SpriteAntigravBullet").visible = false
	
	if itemType == "spoon":
		get_node("SpriteSpoonBullet").visible = true
	
	if itemType == "fireball":
		get_node("SpriteFireballBullet").visible = true
	
	if itemType == "antigrav":
		get_node("SpriteAntigravBullet").visible = true
	
	# Update sprite here

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
			if itemType == "spoon":
				body.wound()
			else:
				body.die()
