extends Node2D

export var pointA :Vector2
export var pointB :Vector2
export var speed :int #Number of frames

var direction
var step

func _ready():
	global_position = pointA
	step = (pointB - pointA) / speed
	
func _process(delta):
	if direction:
		if ((pointB * -1) - (global_position * -1)) > step:
			global_position += step
		else:
			direction = 0
	else:
		if (pointA - global_position) > step:
			global_position -= step
		else:
			direction = 0
	