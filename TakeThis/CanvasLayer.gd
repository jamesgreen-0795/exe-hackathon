extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	draw()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func draw():
	get_node("Lives").text = str(PlayerGlobals.lives)	

func _on_HeartBody_lives_changed():
	draw()