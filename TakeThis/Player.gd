extends KinematicBody2D

class_name Player

export (int) var speed = 300
export (int) var jump_speed = -350
export (int) var gravity = 1000

var velocity = Vector2.ZERO
var Bullet = preload("res://BasicBullet.tscn")
var last_direction = 0

export (int) var shoot_cooldown = 50
var current_cooldown = 0

export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25
export var itemType = "spoon"

func _ready():
	play_animation("Walk")
	
func play_animation(anim):
	get_node("AnimationPlayer").play(anim)

func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
		get_node("Sprite").set_flip_h(false)
		get_node("ItemSpoon").set_flip_h(false)
	if Input.is_action_pressed("ui_left"):
		dir -= 1
		get_node("Sprite").set_flip_h(true)
		get_node("ItemSpoon").set_flip_h(true)
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	if Input.is_mouse_button_pressed(1) and current_cooldown <= 0:
		_create_bullet()
		hide_item()		
		current_cooldown = shoot_cooldown


func _physics_process(delta):
	current_cooldown -= 1
	
	if current_cooldown == 0:
		show_item()
	
	# custom parallaxing based on player position
	var backgroundNode = get_node("Camera2D/CanvasLayer/ParallaxBackground/Sprite")
	backgroundNode.position.x = - ( (position.x * 0.4) - (backgroundNode.get_viewport().size.x / 2));
	
	get_input()
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
	
	# Animate the player walking by the velocity the player moves.
	# capped to 2 times normal playing speed
	get_node("AnimationPlayer").playback_speed = min(velocity.x * delta, 2)
	

func player_direction(x_component):
	if x_component > 0:
		return 1
	if x_component == 0:
		return 0
	if x_component < 0:
		return -1
	return 0

func _create_bullet():
	var b = Bullet.instance()
	b.position = position + get_node("ItemSpoon").transform.get_origin()
	b.itemType = itemType
	get_parent().add_child(b)

func show_item():
	get_node("ItemSpoon").show()

func hide_item():
	get_node("ItemSpoon").hide()

func die():
	queue_free()