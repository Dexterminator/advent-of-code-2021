extends Node2D

func bin2dec(bin_num):
	var n = 0
	for i in len(bin_num):
		if bin_num[-i-1] == "1":
			n |= 1 << i
	return n

func filter_nums(bin_nums, i, filter_char, should_equal):
	var filtered_nums = []
	for num in bin_nums:
		if (should_equal and num[i] == filter_char) or (not should_equal and num[i] != filter_char):
			filtered_nums.push_back(num)

	return filtered_nums

func get_rating(bin_nums, should_equal):
	var curr_nums = bin_nums
	for x in len(bin_nums[0]):
		var counts = {"0": 0, "1": 0}
		for y in len(curr_nums):
			counts[curr_nums[y][x]] += 1

		if counts["1"] > counts["0"] or counts["1"] == counts["0"]:
			curr_nums = filter_nums(curr_nums, x, "1", should_equal)
		else:
			curr_nums = filter_nums(curr_nums, x, "0", should_equal)

		if len(curr_nums) == 1:
			return bin2dec(curr_nums[0])

func part2(bin_nums):
	var oxygen_rating = get_rating(bin_nums, true)
	var co2_rating = get_rating(bin_nums, false)
	return oxygen_rating * co2_rating

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
	print(part2(bin_nums))

func _ready():
	solve()
