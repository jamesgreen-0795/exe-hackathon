extends RigidBody2D

export (int) var speed = 200
export (Vector2) var velocity = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	get_input()
	velocity = velocity

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('right'):
        velocity.x += 1
    if Input.is_action_pressed('left'):
        velocity.x -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
