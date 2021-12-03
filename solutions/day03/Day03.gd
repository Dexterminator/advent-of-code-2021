extends Node2D

func part1(bin_nums):
	var gamma = 0
	var epsilon = 0
	for x in len(bin_nums[0]):
		var counts = {"0": 0, "1": 0}
		for y in len(bin_nums):
			counts[bin_nums[y][-x-1]] += 1
		if counts["1"] > counts["0"]:
			gamma |= 1 << x
		else:
			epsilon |= 1 << x

	return gamma * epsilon

func solve():
	var text = Utils.slurp("res://solutions/day03/input.txt")
	var bin_nums = text.split("\n")
	print(part1(bin_nums))

func _ready():
	solve()
