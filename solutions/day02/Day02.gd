extends Node2D

func part1(instructions):
	var x = 0
	var y = 0
	for instruction in instructions:
		match instruction:
			["forward", var n]: x += n
			["down", var n]: y += n
			["up", var n]: y -= n
	return x * y

func solve():
	var text = Utils.slurp("res://solutions/day02/input.txt")
	var instructions = []
	for line in text.split("\n"):
		var parts = line.split(" ")
		instructions.push_back([parts[0], int(parts[1])])
	print(part1(instructions))

func _ready():
	solve()