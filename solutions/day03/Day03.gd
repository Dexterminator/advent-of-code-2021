extends Node2D

onready var labels = $Labels/LabelList
onready var camera = $ShakeCamera2D
onready var ones = $CanvasLayer/VBoxContainer/Ones
onready var zeroes = $CanvasLayer/VBoxContainer/Zeroes
var viz_steps = []
var num_count

#-------------Visualization----------------#
func init_viz(bin_nums):
	num_count = len(bin_nums)
	for num in bin_nums:
		var hbox = HBoxContainer.new()
		labels.add_child(hbox)
		for x in num:
			var label = Label.new()
			label.text = x
			hbox.add_child(label)

func update_counts(x, y, counts):
	if x != 0 and y == 0:
		yield(get_tree().create_timer(2), "timeout")

	ones.text = "ONES: " + str(counts["1"])
	zeroes.text = "ZEROES: " + str(counts["0"])
	var num_label = labels.get_children()[y].get_children()[x]
	num_label.modulate = Color.lawngreen
	yield(get_tree().create_timer(0.2), "timeout")
	camera.global_position.y = num_label.rect_global_position.y - 100
	num_label.modulate = Color.white



#-------------SOLUTION----------------#
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
			viz_steps.append(["update_counts", x, y, counts.duplicate()])

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

func visualize():
	for step in viz_steps:
		var func_name = step[0]
		var args = step.slice(1, len(step))
		var f = funcref(self, func_name).call_funcv(args)
		if f is GDScriptFunctionState:
			yield(f, "completed")

func solve():
	var text = Utils.slurp("res://solutions/day03/input.txt")
	var bin_nums = text.split("\n")
	init_viz(bin_nums)
	print(part1(bin_nums))
	print(part2(bin_nums))
	visualize()

func _ready():
	solve()
