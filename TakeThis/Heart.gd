extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var taken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

signal lives_changed

func _on_HeartBody_body_entered(body):
	if body.name == "Player" and not taken:
		if PlayerGlobals.lives < PlayerGlobals.max_lives:
			PlayerGlobals.lives += 1
			emit_signal("lives_changed")
		taken = true
		hide()
		queue_free()			