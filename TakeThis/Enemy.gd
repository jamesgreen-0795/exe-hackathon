extends KinematicBody2D

export var pointA :Vector2
export var pointB :Vector2
export var speed :int #Number of frames

var direction
var step

class_name Enemy

func _ready():
	global_position = pointA
	step = (pointB - pointA) / speed
	direction = 1
	
func _process(delta):
	if direction == 1:
		if exceeded(global_position, step, pointB):
			global_position += step
		else:
			direction = 0
	else:
		if exceeded(global_position, -step, pointA):
			global_position -= step
		else:
			direction = 1

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