extends Node2D

onready var day1 = preload("res://solutions/day01/day01.gd").new()

func _process(_delta):
	$Label.text = "DEPTH"

func _ready():
	day1.solve()
