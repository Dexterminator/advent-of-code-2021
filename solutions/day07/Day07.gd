extends Node2D

onready var CrabSubmarine = preload("res://solutions/day07/CrabSubmarine.tscn")
onready var camera = $ShakeCamera2D
var viz_steps = []
var y = 200

func set_best_pos(n):
	for crab_sub in get_tree().get_nodes_in_group("crab_subs"):
		var duration = abs(crab_sub.global_position.x - n) * 0.005
		var a = Anima.begin(crab_sub)
		a.then({node=crab_sub, property="x", to=n, duration=duration, easing=Anima.EASING.EASE_IN_OUT_CIRC})
		a.play()
	var crab_sub = CrabSubmarine.instance()
	crab_sub.global_position = Vector2(n, y)
	add_child(crab_sub)

func init_sub(n):
	var crab_sub = CrabSubmarine.instance()
	crab_sub.global_position = Vector2(n, y)
	add_child(crab_sub)

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
	var best_n = -1
	for n in nums:
		var fuel = get_fuel_funcref.call_func(n, nums)
		if fuel < min_fuel:
			min_fuel = fuel
			best_n = n
	viz_steps.append(["set_best_pos", best_n])
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
	nums.sort()
	for n in nums: viz_steps.push_back(["init_sub", n])
	print(part1(nums))
	# print(part2(nums))

func _ready():
	solve()
	Utils.visualize(viz_steps, self)
