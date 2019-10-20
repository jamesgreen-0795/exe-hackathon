extends RigidBody2D

export var pointA :Vector2
export var pointB :Vector2
export var speed :int #Number of frames

var direction
var step

var has_gravity = true

class_name Enemy

func _ready():
	global_position = pointA
	step = (pointB - pointA) / speed
	direction = 1
	get_node("Sprite").set_flip_h(true)
	
func _process(delta):
	if has_gravity:
		if direction == 1:
			if exceeded(global_position, step, pointB):
				global_position += step
			else:
				direction = 0
				get_node("Sprite").set_flip_h(false)
		else:
			if exceeded(global_position, -step, pointA):
				global_position -= step
			else:
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
	queue_free()

func remove_gravity():
	gravity_scale = -1
	angular_velocity = 10
	linear_velocity.x = 0
	has_gravity = false

func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.die()
