extends RigidBody2D

export (int) var speed = 100
export (int) var maxSpeed = 200

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	update_input(delta)

func update_input(delta):
	
    if Input.is_action_pressed('ui_right') and self.linear_velocity.x < maxSpeed:
        self.linear_velocity.x += speed * delta
    if Input.is_action_pressed('ui_left') and self.linear_velocity.x > -maxSpeed :
        self.linear_velocity.x -= speed * delta
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
