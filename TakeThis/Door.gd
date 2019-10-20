extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var next_level = "Lvl2"
export var next_level_item_name = ""

var showTitle = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (showTitle == true):
		get_node("CanvasLayer/TextureRect").modulate.a += 0.1;
	pass

func go_to_next_level():
	get_tree().change_scene("res://" + next_level + ".tscn")

func _on_Door_body_entered(body):
	if body.name == "Player":
		showTitle = true
		get_node("CanvasLayer/Label").text = next_level_item_name
		var tweenLevel = get_node("TweenLevel")
		tweenLevel.interpolate_callback(self, 4, "go_to_next_level")
		tweenLevel.start()
		