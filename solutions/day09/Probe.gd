extends KinematicBody2D

var dir = Vector2.RIGHT

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	dir = move_and_slide(dir)
