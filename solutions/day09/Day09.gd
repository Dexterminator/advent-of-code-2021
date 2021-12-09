extends Node2D

func get_risk_level(x, y, heights):
	var current = heights[y][x]
	var left = heights[y][x-1] if x != 0 else Utils.MAX_INT
	var right = heights[y][x+1] if x != len(heights[y]) - 1 else Utils.MAX_INT
	var up = heights[y-1][x] if y != 0 else Utils.MAX_INT
	var down = heights[y+1][x] if y != len(heights) - 1 else Utils.MAX_INT

	for other in [left, right, down, up]:
		if current >= other:
			return 0

	return 1 + current


func part1(heights):
	var risk_level_sum = 0
	for y in len(heights):
		for x in len(heights[y]):
			risk_level_sum += get_risk_level(x, y, heights)

	return risk_level_sum

func solve():
	# var input = """2199943210
	# 3987894921
	# 9856789892
	# 8767896789
	# 9899965678"""
	var input = Utils.slurp("res://solutions/day09/input.txt")

	var heights = []
	for line in input.split("\n"):
		var line_heights = []
		for n in line: line_heights.push_back(int(n))
		heights.push_back(line_heights)
	print(part1(heights))

func _ready():
	solve()
