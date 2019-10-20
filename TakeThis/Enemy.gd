extends RigidBody2D

export var pointA :Vector2
export var pointB :Vector2
export var speed :int #Number of frames

var direction
var step

var wounded = false

var has_gravity = true
var is_dead = false

class_name Enemy

func _ready():
	global_position = pointA
	step = (pointB - pointA) / speed
	direction = 1
	get_node("Sprite").set_flip_h(true)
	
func _process(delta):
	
	if is_dead:
		var addedRotation = 10
		if (direction == 0):
			addedRotation = -addedRotation
		rotation_degrees += addedRotation
		linear_velocity.x = 0
		get_node("Sprite").modulate.a -= 0.1
		get_node("Sprite").modulate.r += 5
	
	if has_gravity:
		if direction == 1:
			if exceeded(global_position, step, pointB):
				global_position += step
			else:
				direction = 0
				global_position = pointB
				get_node("Sprite").set_flip_h(false)
		else:
			if exceeded(global_position, -step, pointA):
				global_position -= step
			else:
				global_position = pointA
				direction = 1
				get_node("Sprite").set_flip_h(true)

func exceeded(current, s, target):
	if s.x > 0:
		if current.x > target.x:
			return false
	else:
		if current.x < target.x:
			return false
	if s.y > 0:
		if current.y > target.y:
			return false
	else:
		if current.y < target.y:
			return false
	return true

func die():
	is_dead = true;
	var tween = get_node("Tween")
	tween.interpolate_callback(self, 0.25, "queue_free")
	tween.start()

func remove_gravity():
	gravity_scale = -1
	angular_velocity = 10
	linear_velocity.x = 0
	has_gravity = false

func wound():
	if not wounded:
		wounded = true
	else:
		die()

func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.die()
