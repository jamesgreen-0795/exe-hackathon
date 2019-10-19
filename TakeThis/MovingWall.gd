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
	global_position += step