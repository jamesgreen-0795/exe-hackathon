extends KinematicBody2D

export (int) var speed = 300
export (int) var jump_speed = -350
export (int) var gravity = 1000

var velocity = Vector2.ZERO
var Bullet = preload("res://BasicBullet.tscn")

export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25

func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	if Input.is_mouse_button_pressed(1):
		_create_bullet()


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed

func _create_bullet():
	var b = Bullet.instance()
	b.position = position
	get_parent().add_child(b)