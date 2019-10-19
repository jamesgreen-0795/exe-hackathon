extends Node2D

export var pointA :Vector2
export var pointB :Vector2
export var speed :int #Number of frames

var direction
var step

func _ready():
	global_position = pointA
	step = (pointB - pointA) / speed
	direction = 1
	get_node("KinematicBody2D/Sprite").set_flip_h(true)
	
func _process(delta):
	if direction == 1:
		if exceeded(global_position, step, pointB):
			global_position += step
		else:
			direction = 0
			get_node("KinematicBody2D/Sprite").set_flip_h(false)
	else:
		if exceeded(global_position, -step, pointA):
			global_position -= step
		else:
			direction = 1
			get_node("KinematicBody2D/Sprite").set_flip_h(true)

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