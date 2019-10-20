extends KinematicBody2D

class_name Player

export (int) var speed = 300
export (int) var jump_speed = -350
export (int) var gravity = 1000
export (int) var fall_death = 10000
export  var level = "Lvl1"

var velocity = Vector2.ZERO
var Bullet = preload("res://BasicBullet.tscn")
var last_direction = 0

var stopped = 1

export (int) var shoot_cooldown = 50
var current_cooldown = 0
onready var nodeItemSpoon = get_node("ItemSpoon")

export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25
export var itemType = "spoon"

signal player_walk_ground
signal player_stop

func _ready():
	play_animation("Walk")
	
func play_animation(anim):
	get_node("AnimationPlayer").play(anim)

func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
		get_node("Sprite").set_flip_h(false)
		nodeItemSpoon.set_flip_h(false)
		nodeItemSpoon.position.x = abs(nodeItemSpoon.position.x)
	if Input.is_action_pressed("ui_left"):
		dir -= 1
		get_node("Sprite").set_flip_h(true)
		nodeItemSpoon.set_flip_h(true)
		nodeItemSpoon.position.x = -abs(nodeItemSpoon.position.x)
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	if Input.is_mouse_button_pressed(1) and current_cooldown <= 0:
		_create_bullet()
		hide_item()		
		current_cooldown = shoot_cooldown


func _physics_process(delta):
	if global_position.y > fall_death:
		die()
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
	
	if ((is_on_floor() and velocity.x < 10 and velocity.x > -10) or not is_on_floor()) and stopped == 0:
		print_debug("stop")
		emit_signal("player_stop")
		stopped = 1
	if is_on_floor() and (velocity.x > 10 or velocity.x < -10) and stopped == 1:
		print_debug("start")		
		emit_signal("player_walk_ground")
		stopped = 0 
		
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
	b.position = position + nodeItemSpoon.transform.get_origin()
	b.itemType = itemType
	get_parent().add_child(b)

func show_item():
	nodeItemSpoon.show()

func hide_item():
	nodeItemSpoon.hide()

func die():
	PlayerGlobals.lives -= 1
	
	if PlayerGlobals.lives < 0:
		PlayerGlobals.lives = PlayerGlobals.default_lives
		get_tree().change_scene("res://MainMenu.tscn")
	else:
		get_tree().change_scene("res://" + level + ".tscn")
	queue_free()


