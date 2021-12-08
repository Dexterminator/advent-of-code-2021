extends Node2D

func get_crab_engineering_fuel(target, nums):
	var fuel = 0
	for n in nums:
		var diff = abs(target-n)
		for i in diff: fuel += i+1
	return fuel

func get_fuel(target, nums):
	var fuel = 0
	for n in nums:
		fuel += abs(target-n)
	return fuel

func get_min_fuel(nums, get_fuel_funcref):
	var min_fuel = Utils.MAX_INT
	for n in nums:
		var fuel = get_fuel_funcref.call_func(n, nums)
		if fuel < min_fuel:
			min_fuel = fuel
	return min_fuel

func part2(nums):
	return get_min_fuel(nums, funcref(self, "get_crab_engineering_fuel")) 

func part1(nums):
	return get_min_fuel(nums, funcref(self, "get_fuel")) 

func solve():
	# var input = "16,1,2,0,4,2,7,1,2,14"
	var input = Utils.slurp("res://solutions/day07/input.txt")
	var nums = []
	for n in input.split(","): nums.push_back(int(n))
	# nums.sort()
	print(part1(nums))
	print(part2(nums))

func _ready():
	solve()
