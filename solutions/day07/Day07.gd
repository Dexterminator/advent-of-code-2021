extends Node2D

func get_fuel(target, nums):
	var fuel = 0
	for n in nums:
		fuel += abs(target-n)
	return fuel

func part1(nums):
	var min_fuel = Utils.MAX_INT
	for n in nums:
		var fuel = get_fuel(n, nums)
		if fuel < min_fuel:
			min_fuel = fuel
	return min_fuel

func solve():
	# var input = "16,1,2,0,4,2,7,1,2,14"
	var input = Utils.slurp("res://solutions/day07/input.txt")
	var nums = []
	for n in input.split(","): nums.push_back(int(n))
	print(part1(nums))

func _ready():
	solve()
