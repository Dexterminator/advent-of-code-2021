extends Node

func part1(depths):
	var count = 0
	for i in range(1, len(depths)):
		if depths[i] > depths[i-1]:
			count += 1
	return count

func part2(depths):
	var count = 0
	for i in range(1, len(depths) - 2):
		var prev_depth_sum = depths[i-1] + depths[i] + depths[i+1]
		var depth_sum = depths[i] + depths[i+1] + depths[i+2]
		if depth_sum > prev_depth_sum:
			count += 1
	return count

func solve():
	var text = Utils.slurp("res://solutions/day01/input.txt")
	var depths = []
	for line in text.split("\n"): depths.push_back(int(line))
	print(part1(depths))
	print(part2(depths))
