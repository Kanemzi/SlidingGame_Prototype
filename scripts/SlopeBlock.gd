extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var id = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("slopeblocks")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
