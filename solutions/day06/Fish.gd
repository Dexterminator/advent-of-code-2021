extends Node2D

var dir

func _ready():
	dir = Vector2(rand_range(-1, 1), rand_range(-1, 1))

func _process(delta):
	global_position += dir * 10 * delta
